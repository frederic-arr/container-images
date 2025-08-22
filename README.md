# Container Images

A collection of secure container images for applications that lack official container images.

## Features

- Built from source
- Non-root execution
- Standardized filesystem layout
- Multi-architecture support

## Available Images

- [`bird`](./apps/bird/README.md)
<!-- - [`bird-exporter`](./apps/bird-exporter/README.md)
- [`knot-dns`](./apps/knot-dns/README.md)
- [`knot-dns-exporter`](./apps/knot-dns/README.md)
- [`knot-resolver`](./apps/knot-resolver/README.md) -->

## Usage

### Registry

All images are available from the following registries:
- `docker.io/fredericarr`

### Supported tags

All images follow a similar tagging strategy.

#### Application version tags

- `latest`
- `<major>` (e.g. `3`)
- `<minor>` (e.g. `3.1`)
- `<version>` (e.g. `3.1.2`)

#### OS-specific tags

- `<os_name>(-<os_variant>)` (e.g. `alpine`)
- `<os_name><os_version>(-<os_variant>)` (e.g. `alpine3.22.1`)
- `<os_name><major_os_version>(-<os_variant>)` (e.g. `alpine3`)
- `<os_name><minor_os_version>(-<os_variant>)` (e.g. `alpine3.22`)

#### Combined application and OS tags

- `3.1.2-alpine`
- `3-alpine3.22.1`
- *etc.*

### Supported distributions

When possible, images are available in the following distributions:

- `alpine` (default)
<!-- - `debian`
- `debian-slim`
- `ubuntu` -->

> [!NOTE]
> Application supporting static compilation will not have any OS-specific tags, Additionally, some applications might not be available on specific distributions, check individual application READMEs for specific distribution availability.

### Supported architectures

When possible, images are available in the following architectures:

- `linux/amd64` (`x86_64`)
<!-- - `linux/armd64` (`aarch64`) -->

> [!NOTE]
> Check individual application READMEs for specific architecture availability.

## Contributing

For contribution guidelines see [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

Copyright (c) Bob Moran. [Apache 2.0 License](./LICENSE).

> [!IMPORTANT]
> Individual applications may be subject to their respective upstream licenses. Please check each application's directory and upstream project for specific licensing information.

<hr />
<small>These are unofficial container images. For official support of the applications themselves, please contact their respective upstream maintainers.</small>
