FROM docker.io/centos:7
MAINTAINER Kazuhisa Hara <kazuhisya@gmail.com>

ENV TZ="JST-9" \
    MAINTAINER="Kazuhisa Hara <kazuhisya@gmail.com>" \
    NGINX_VERSION="1.11.5" \
    LUA_VERSION="0.10.7" \
    NDK_VERSION="0.3.0"

RUN yum install -y --setopt=tsflags=nodocs epel-release && \
    yum install -y --setopt=tsflags=nodocs \
    GeoIP-devel \
    gcc \
    gd-devel \
    gettext \
    libxslt-devel \
    luajit \
    luajit-devel \
    make \
    openssl-devel \
    pcre-devel \
    perl-ExtUtils-Embed \
    perl-devel \
    redhat-rpm-configa \
    rpm-build \
    rpmdevtools \
    which \
    yum-utils \
    zlib-devel \
    copr-cli && \
    yum clean all && \
    rpmdev-setuptree

WORKDIR /root/rpmbuild
COPY / nginx-module-ndk-lua

RUN curl -L http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    -o SOURCES/nginx-${NGINX_VERSION}.tar.gz && \
    curl -L https://github.com/openresty/lua-nginx-module/archive/v${LUA_VERSION}.tar.gz \
    -o SOURCES/lua-nginx-module-${LUA_VERSION}.tar.gz && \
    curl -L https://github.com/simpl/ngx_devel_kit/archive/v${NDK_VERSION}.tar.gz \
    -o SOURCES/ngx_devel_kit-${NDK_VERSION}.tar.gz


RUN cat nginx-module-ndk-lua/nginx-module-ndk-lua.spec.template \
    | TODAY=$(LANG=c date +"%a %b %e %Y") envsubst '$NGINX_VERSION, $LUA_VERSION, $NDK_VERSION, $MAINTAINER, $TODAY' \
    > SPECS/nginx-module-ndk-lua.spec && \
    rpmbuild -ba SPECS/nginx-module-ndk-lua.spec
