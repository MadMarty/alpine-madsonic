FROM alpine:edge
MAINTAINER madsonic <support@madsonic.org>

# Madsonic Package Information
ENV PKG_NAME madsonic
ENV PKG_VER 6.1
ENV PKG_BUILD 8550
ENV PKG_DATE 20160727
ENV TAR_NAME ${PKG_DATE}_${PKG_NAME}-${PKG_VER}.${PKG_BUILD}.tar.gz

ENV GID=991 UID=991

WORKDIR /madsonic

RUN echo "@commuedge https://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk -U add \
    ffmpeg \
    openjdk8-jre@commuedge \
    tini@commuedge \
 && wget -qO- http://madsonic.org/download/${PKG_VER}/${TAR_NAME} | tar zxf - \
 && rm -f /var/cache/apk/*

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 4040
EXPOSE 4050

VOLUME /config /media /playlists /podcasts

LABEL description "Open source media streamer" \
      madsonic "Madsonic v6.1"

CMD ["/sbin/tini","--","start.sh"]
