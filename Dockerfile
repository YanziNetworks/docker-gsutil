FROM alpine:3.10

LABEL maintainer "Emmanuel Frecon <efrecon@gmail.com>"
ARG GSUTIL_VERSION=4.39

RUN apk add --no-cache python2 curl tar tini && \
    curl -qLs https://pub.storage.googleapis.com/gsutil_${GSUTIL_VERSION}.tar.gz | tar -C /opt -zxvf - && \
    apk del --no-cache curl tar && \
    ln -s /opt/gsutil/gsutil /usr/local/bin/gsutil

ENTRYPOINT [ "/sbin/tini", "--", "/usr/local/bin/gsutil" ]
CMD [ "help" ]