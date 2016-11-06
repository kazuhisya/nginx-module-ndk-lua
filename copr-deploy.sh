#!/bin/bash
set -e
project_name=nginx-module-ndk-lua
copr_login=$COPR_LOGIN
copr_username=$COPR_USERNAME
copr_token=$COPR_TOKEN


mkdir -p ~/.config
cat > ~/.config/copr <<EOF
[copr-cli]
login = ${copr_login}
username = ${copr_username}
token = ${copr_token}
copr_url = https://copr.fedoraproject.org
EOF

srpm_file=`basename SRPMS/*.src.rpm`
copr-cli build --nowait ${project_name} /root/rpmbuild/SRPMS/${srpm_file}


