#!/bin/bash
#  "bash docker-project_init.sh 82"
#  Script_Name: docker-project_init.sh
#  运行于项目环境（测试或者生产）

source /usr/local/jenkins/home/scripts/config.ini
source /usr/local/jenkins/home/scripts/.version.ini
#SERVER_PORT=$1                          ##项目对外服务端口


docker pull ${DOCKER_REGISTRY}:${DS_PORT}/${BASE_IMAGE}:${VERSION}

echo ${SERVER_PORT}
##停止原有对外服务容器
old_cid=$(docker ps -a |grep ":${SERVER_PORT}-" | awk '{print $1}')
if [ -n $old_cid ];then
    docker stop ${old_cid}
fi

##用新的镜像创建并运行服务
docker run -d -p ${SERVER_PORT}:80 --name ${PROJECT_NAME}-${VERSION}_test ${DOCKER_REGISTRY}:${DS_PORT}/${BASE_IMAGE}:${VERSION}

#curl -XGET http://${DOCKER_REGISTRY}:${DS_PORT}/v2/${BASE_IMAGE}/tags/list
