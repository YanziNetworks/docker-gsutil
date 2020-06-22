FROM alpine:3.11.3

LABEL maintainer "Emmanuel Frecon <efrecon+github@gmail.com>"
ARG GSUTIL_VERSION=4.51
ARG CRC32C_VERSION=1.7

RUN apk add --no-cache python3 curl tar tini python-dev gcc musl-dev && \
    curl -qLs https://downloads.sourceforge.net/project/crcmod/crcmod/crcmod-${CRC32C_VERSION}/crcmod-${CRC32C_VERSION}.tar.gz | tar -zxf - && \
    cd crcmod-${CRC32C_VERSION} && \
    python setup.py install && \
    cd .. && \
    rm -rf crcmod-${CRC32C_VERSION} && \
    curl -qLs https://pub.storage.googleapis.com/gsutil_${GSUTIL_VERSION}.tar.gz | tar -C /opt -zxf - && \
    apk del --no-cache curl tar gcc && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    ln -s /opt/gsutil/gsutil /usr/local/bin/gsutil

ENTRYPOINT [ "/sbin/tini", "--", "/usr/local/bin/gsutil" ]
CMD [ "help" ]

LABEL org.opencontainers.image.title="gsutil"
LABEL org.opencontainers.image.description="gsutil is an application that lets you access Cloud Storage from the command line."
LABEL org.opencontainers.image.authors="Emmanuel Frecon <efrecon+github@gmail.com>"
LABEL org.opencontainers.image.url="https://github.com/YanziNetworks/docker-gsutil"
LABEL org.opencontainers.image.documentation="https://github.com/YanziNetworks/docker-gsutil/README.md"
LABEL org.opencontainers.image.source="https://github.com/YanziNetworks/docker-gsutil"
LABEL org.opencontainers.image.version="$GSUTIL_VERSION"
LABEL org.opencontainers.image.vendor="Yanzi Networks AB"
LABEL org.opencontainers.image.licenses="MIT"