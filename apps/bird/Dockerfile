ARG BASE_IMAGE="scratch"
ARG APP_VERSION

FROM ${BASE_IMAGE} AS build
ARG BASE_IMAGE
ARG APP_VERSION

RUN if [ "$(echo $BASE_IMAGE | grep alpine)" ]; then \
        apk add --no-cache \
            musl-dev \
            linux-headers \
            gcc \
            make \
            bison \
            ca-certificates \
            flex \
            ncurses-dev \
            readline-dev \
            libssh-dev \
            m4; \
    else \
        echo "Unknown distribution ${BASE_IMAGE}"; \
        exit 1; \
    fi

WORKDIR /app/build
ADD https://bird.network.cz/download/bird-${APP_VERSION}.tar.gz .
RUN set -eux \
    && mkdir ./src/ \
    && tar -xzvf bird-${APP_VERSION}.tar.gz --strip-components 1 -C ./src/ \
    && cd ./src/ \
    && ./configure \
        --enable-libssh \
        --enable-mpls-kernel \
    && make daemon

FROM ${BASE_IMAGE}
ARG BASE_IMAGE

RUN if [ "$(echo $BASE_IMAGE | grep alpine)" ]; then \
        apk add --no-cache libssh; \
    else \
        echo "Unknown distribution ${BASE_IMAGE}"; \
        exit 1; \
    fi

RUN if [ "$(echo $BASE_IMAGE | grep alpine)" ]; then \
        adduser -h /home/app -Ds /bin/sh app; \
    else \
        echo "Unknown distribution ${BASE_IMAGE}"; \
        exit 1; \
    fi

USER app
WORKDIR /app
COPY --chown=app:app --from=build /app/build/src/bird ./bin/
COPY --chown=app:app --from=build /app/build/src/doc/bird.conf.example /app/config/bird.conf
RUN mkdir -p ./run ./config

ENTRYPOINT [ "/app/bin/bird", "-P", "/app/run/bird.pid", "-s", "/app/run/bird.ctl", "-c", "/app/config/bird.conf", "-f" ]
