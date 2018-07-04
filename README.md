# nginx-module-ndk-lua


| CI         | RPM        |
|:----------:|:----------:|
| [![Circle CI](https://circleci.com/gh/kazuhisya/nginx-module-ndk-lua/tree/master.svg?style=shield)](https://circleci.com/gh/kazuhisya/nginx-module-ndk-lua/tree/master) | [![FedoraCopr](https://copr.fedorainfracloud.org/coprs/khara/nginx-module-ndk-lua/package/nginx/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/khara/nginx-module-ndk-lua/) |


This repository provides unofficial rpmbuild scripts for CentOS.

- nginx-module-lua - Embed the Power of Lua into NGINX HTTP servers
    - [openresty/lua-nginx-module: Embed the Power of Lua into NGINX HTTP servers](https://github.com/openresty/lua-nginx-module)
- nginx-module-ndk - Nginx Development Kit
    - [simpl/ngx_devel_kit: Nginx Development Kit - an Nginx module that adds additional generic tools that module developers can use in their own modules](https://github.com/simpl/ngx_devel_kit)

Both are built as dynamic modules conforming to upstream nginx package.

## Distro support

Tested working on:

- CentOS 7 x86_64
    - When you try to build on el7/el6, must enable the EPEL repository.

## Install (CentOS7)

```bash
$ sudo yum install -y epel-release
$ sudo yum install -y http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
$ sudo sed -i -e 's@/packages/@/packages/mainline/@' /etc/yum.repos.d/nginx.repo
$ sudo curl -L https://copr.fedorainfracloud.org/coprs/khara/nginx-module-ndk-lua/repo/epel-7/khara-nginx-module-ndk-lua-epel-7.repo -o /etc/yum.repos.d/nginx-module-ndk-lua.repo
$ sudo yum install -y nginx nginx-module-lua
```

## Version of the corresponding nginx

- `mainline` only

`/etc/yum.repos.d/nginx.repo`

```
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
```


## Disclaimer

- This repository and all files that are included in this, there is no relationship at all with the upstream and vendor.

