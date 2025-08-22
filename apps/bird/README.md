# BIRD Internet Routing Daemon

This image provides the [BIRD Internet Routing Daemon](https://bird.network.cz/) as a non-root container.

## Quick Start

```sh
docker pull fredericarr/bird
docker run \
    --rm \
    --cap-add NET_BIND_SERVICE \
    --cap-add NET_BROADCAST \
    --cap-add NET_ADMIN \
    --cap-add NET_RAW
    --mount type=bind,src=$(pwd)/bird.conf,dst=/app/config/bird.conf \
    --name bird3 fredericarr/bird
```

## Container Requirements

The container should have the following capabilities:

- `NET_BIND_SERVICE`
- `NET_BROADCAST`
- `NET_ADMIN`
- `NET_RAW`

**Network Mode:** `host`

## Configuration

This image expects the config files to be placed under `/app/config/bird.conf`.

The following files will also be created at runtime:

- **PID file**: `/app/run/bird.pid`
- **Control socket**: `/app/run/bird.ctl`

## Supported tags

- `latest`
- `<major>.<minor>.<patch>` (e.g. `3.1.2`)
- `<major>.<minor>` (e.g. `3.1`)
- `<major>` (e.g. `3`)

*Please refer to https://github.com/frederic-arr/container-images for the complete tagging strategy.*

## Quick reference

- **BIRD Source Code**: https://gitlab.nic.cz/labs/bird/tree/master
- **BIRD Documentation**: https://bird.network.cz/?get_doc&f=bird.html&v=30
- **Where to file issues**: https://github.com/frederic-arr/container-images
- **Source of the image**: https://github.com/frederic-arr/container-images/tree/main/apps/bird
- **Maintained by**: Frédéric Arroyo (https://github.com/frederic-arr)
- **Supported distributions**:
  - `alpine` (default)
- **Supported platforms**:
  - `linux/amd64`

<hr />
<small>This is an unofficial container images. For official support of BIRD itself, please contact the respective upstream maintainers.</small>
