// Copyright (c) Frédéric Arroyo.
// SPDX-License-Identifier: Apache-2.0

base_images = {
    alpine = "alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1"
}

images = [base_images.alpine]

repo_root = "https://github.com/frederic-arr/container-images"

bird_version = "3.1.2"

target "bird" {
    name = make_name("bird", image)
    context = "./apps/bird"
    args = {
        "APP_VERSION" = bird_version
        "BASE_IMAGE" = image
    }
    matrix = {
        "image" = with_prod(images)
    }
    tags = make_tags("bird", bird_version, image, "alpine")
    labels = make_labels(bird_version, {
        "org.opencontainers.image.title" = "BIRD Internet Routing Daemon"
        "org.opencontainers.image.description" = "BIRD is an (not only) IP routing daemon."
        "org.opencontainers.image.licenses" = "GPL-2.0-or-later"
    })
    platforms = with_prod(["linux/amd64"])
}

/**********************************************************
 *                                                        *
 * Functions                                              *
 *                                                        *
 **********************************************************/
variable "PROD" {
    default = false
}

variable "REGISTRIES" {
    default = [""]
}

function "with_prod" {
    params = [data]
    result = PROD ? data : [data[0]]
}

// https://regex101.com/r/80rtng/1
function "get_image" {
    params = [image]
    result = regex("^(?:\\w+/)?(\\w+):", image)[0]
}

// https://regex101.com/r/UY4c7C/1
function "get_version" {
    params = [image]
    result = regex("^[^:]+:(\\d+\\.\\d+(?:\\.\\d+)?)[@-]", image)[0]
}

// https://regex101.com/r/C0NoeA/1
function "get_variant" {
    params = [image]
    result = try(regex("^[^:]+:[\\d.]+(-\\w+)@", image)[0], "")
}

function "major" {
    params = [v]
    result = regex("^\\d+", v)
}

function "minor" {
    params = [v]
    result = regex("^\\d+\\.\\d+", v)
}

function "make_name" {
    params = [app, image]
    result = "${app}-${get_image(image)}${get_variant(image)}"
}

function "make_labels" {
    params = [version, extras]
    result = merge({
        "org.opencontainers.image.vendor" = "Frédéric ARROYO (https://github.com/frederic-arr)"
        "org.opencontainers.image.version" = "${version}"
        "org.opencontainers.image.source" = "${repo_root}"
        "org.opencontainers.image.url" = "${repo_root}"
        "org.opencontainers.image.documentation" = "${repo_root}"
        "org.opencontainers.image.created" = "${timestamp()}"
    }, extras)
}

function "make_tags" {
    params = [app, version, image, default_os]
    result = PROD ? flatten([
        for r in REGISTRIES : _make_tags(app, version, get_image(image), get_variant(image), get_version(image), default_os, r)
    ]) : ["${app}:latest"]
}

function "_make_tags" {
    params = [app, version, os_name, os_variant, os_version, default_os, registry]
    result = concat(
        equal(default_os, "${os_name}${os_variant}") ? [
            "${registry}${app}:latest",
            "${registry}${app}:${version}",
            "${registry}${app}:${minor(version)}",
            "${registry}${app}:${major(version)}",
        ] : [],
        [
            "${registry}${app}:latest-${os_name}${os_version}${os_variant}",
            "${registry}${app}:latest-${os_name}${minor(os_version)}${os_variant}",
            "${registry}${app}:latest-${os_name}${major(os_version)}${os_variant}",
            "${registry}${app}:latest-${os_name}${os_variant}",

            "${registry}${app}:${os_name}${os_version}${os_variant}",
            "${registry}${app}:${os_name}${minor(os_version)}${os_variant}",
            "${registry}${app}:${os_name}${major(os_version)}${os_variant}",
            "${registry}${app}:${os_name}${os_variant}",

            "${registry}${app}:${version}-${os_name}${os_version}${os_variant}",
            "${registry}${app}:${version}-${os_name}${minor(os_version)}${os_variant}",
            "${registry}${app}:${version}-${os_name}${major(os_version)}${os_variant}",
            "${registry}${app}:${version}-${os_name}${os_variant}",

            "${registry}${app}:${minor(version)}-${os_name}${os_version}${os_variant}",
            "${registry}${app}:${minor(version)}-${os_name}${minor(os_version)}${os_variant}",
            "${registry}${app}:${minor(version)}-${os_name}${major(os_version)}${os_variant}",
            "${registry}${app}:${minor(version)}-${os_name}${os_variant}",

            "${registry}${app}:${major(version)}-${os_name}${os_version}${os_variant}",
            "${registry}${app}:${major(version)}-${os_name}${minor(os_version)}${os_variant}",
            "${registry}${app}:${major(version)}-${os_name}${major(os_version)}${os_variant}",
            "${registry}${app}:${major(version)}-${os_name}${os_variant}",
        ]
    )
}
