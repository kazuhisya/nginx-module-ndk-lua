FROM docker.io/centos:7
MAINTAINER Kazuhisa Hara <kazuhisya@gmail.com>

ENV TZ="JST-9" \
    MAINTAINER="Kazuhisa Hara <kazuhisya@gmail.com>" \
    NGINX_VERSION="1.11.13" \
    NGINX_RELEASE="1" \
    LUA_VERSION="0.10.8" \
    LUA_RELEASE="1" \
    NDK_VERSION="0.3.0" \
    NDK_RELEASE="1"

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
    redhat-rpm-config \
    rpm-build \
    rpmdevtools \
    which \
    yum-utils \
    zlib-devel \
    copr-cli && \
    yum clean all && \
    rpmdev-setuptree

WORKDIR /root/rpmbuild

RUN curl -L http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    -o SOURCES/nginx-${NGINX_VERSION}.tar.gz && \
    curl -L https://github.com/openresty/lua-nginx-module/archive/v${LUA_VERSION}.tar.gz \
    -o SOURCES/lua-nginx-module-${LUA_VERSION}.tar.gz && \
    curl -L https://github.com/simpl/ngx_devel_kit/archive/v${NDK_VERSION}.tar.gz \
    -o SOURCES/ngx_devel_kit-${NDK_VERSION}.tar.gz

COPY / nginx-module-ndk-lua

RUN cat nginx-module-ndk-lua/nginx-module-ndk-lua.spec.template \
    | TODAY=$(LANG=c date +"%a %b %e %Y") envsubst '$MAINTAINER, $NGINX_VERSION, $NGINX_RELEASE, $LUA_VERSION, $LUA_RELEASE, $NDK_VERSION, $NDK_RELEASE, $TODAY' \
    > SPECS/nginx-module-ndk-lua.spec && \
    cp -f nginx-module-ndk-lua/*.patch SOURCES/ && \
    rpmbuild -ba SPECS/nginx-module-ndk-lua.spec

RUN cp nginx-module-ndk-lua/nginx.repo /etc/yum.repos.d/ && \
    yum install -y \
        --nogpgcheck \
        --disablerepo=epel \
        ./RPMS/x86_64/nginx-module-* && \
    yum clean all && \
    nginx -T -c /root/rpmbuild/nginx-module-ndk-lua/nginx-test.conf
