FROM jenkinsci/blueocean:latest

USER root

ENV GLIBC 2.29-r0

RUN curl -fsSL -o /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && curl -fsSL -o glibc-$GLIBC.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC/glibc-$GLIBC.apk \
    && apk add --no-cache glibc-$GLIBC.apk \
    && ln -s /lib/libz.so.1 /usr/glibc-compat/lib/ \
    && ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib \
    && ln -s /usr/lib/libgcc_s.so.1 /usr/glibc-compat/lib \
    && rm /etc/apk/keys/sgerrand.rsa.pub glibc-$GLIBC.apk \
    && curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

USER jenkins
