FROM alpine:3.10

MAINTAINER Emmanuel Frecon <efrecon@gmail.com>
ARG GSUTIL_VERSION=4.39

RUN adduser -SD gsutil && \
    apk add --no-cache python2 curl tar && \
    curl -qLs https://pub.storage.googleapis.com/gsutil_${GSUTIL_VERSION}.tar.gz | tar -C /opt -zxvf - && \
    apk del --no-cache curl tar && \
    ln -s /opt/gsutil/gsutil /usr/local/bin/gsutil

WORKDIR /home/gsutil
USER gsutil
ENTRYPOINT [ "/usr/local/bin/gsutil" ]