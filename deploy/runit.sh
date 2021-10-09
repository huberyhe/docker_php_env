#!/usr/bin/env sh
CWD=$(cd $(dirname $0) && pwd)
ROOT_DIR=$(cd ${CWD}/.. && pwd)

# 1、先准备文件到 release\host_rootfs
# 2、将 release\host_rootfs 目录中的文件拷贝到主机根目录
# 3、进入 deploy\compose.dockerfiles ， docker-compose up -d 部署

rootfs_dir=${ROOT_DIR}/release/host_rootfs
compose_dir=${ROOT_DIR}/deploy/compose.dockerfiles
webui_dir=${ROOT_DIR}/webui

type docker-compose >/dev/null 2>&1 || { echo >&2 "I require docker-compose but it's not installed.  Aborting."; exit 1; }

echo '>>> stop and remove old containers...'
rm -rf /wns
docker stop vh_web vh_php vh_mysql vh_redis
docker rm vh_web vh_php vh_mysql vh_redis
docker rmi $(docker images | grep composedockerfiles | awk '{print $3}')

echo '>>> cp files...'
cp ${webui_dir}/* ${rootfs_dir}/wns/webui/ -Ra
cp ${rootfs_dir}/* / -Ra

echo '>>> build containers...'
cd ${compose_dir} && docker-compose up -d --build

echo '>>> enable ext in vh_php...'
docker exec vh_php docker-php-ext-enable gd zip pdo_mysql opcache mysqli
docker restart vh_php

echo '>>> Done.'
