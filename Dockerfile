FROM alpine:edge
MAINTAINER madsonic <support@madsonic.org>

ENV GID=991 UID=991

WORKDIR /madsonic

RUN echo "@commuedge https://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk -U add \
    ffmpeg \
    openjdk8-jre@commuedge \
    tini@commuedge \
 && wget -qO- http://madsonic.org/download/6.2/20161208_madsonic-6.2.9040-standalone.tar.gz | tar zxf - \
 && rm -f /var/cache/apk/*

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 4040
EXPOSE 4050

VOLUME /config /media /playlists /podcasts

LABEL description "Open source media streamer" \
      madsonic "Madsonic v6.2"

CMD ["/sbin/tini","--","start.sh"]
