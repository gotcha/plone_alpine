FROM gotcha/buildout_docker_alpine
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
    zlib-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    pcre-dev \
    openssl \
&& addgroup -g 500 plone \
&& adduser -S -D -G plone -u 500 plone \
&& chown -R plone:plone /usr/src/app
ENV DOCKERIZE_VERSION v0.11.0
RUN wget -O - https://github.com/powerman/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-`uname -s`-`uname -m` | install /dev/stdin /bin/dockerize
USER plone
COPY ./buildout-p5.cfg /usr/src/app/buildout-p5.cfg
RUN buildout -c /usr/src/app/buildout-p5.cfg
EXPOSE 8080
