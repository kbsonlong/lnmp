#!/bin/bash
# Name   :  jenkins_build.sh
# Author :  蜷缩的蜗牛
# Site   :  www.along.party
# Version:  V0.1
# Info   :  打包项目代码，构建docker镜像，push镜像到docker仓库

DOCKER_REGISTRY=192.168.52.201          ##docker仓库地址
DS_PORT=5000                            ##docker仓库端口
JENKINS_HOME=/usr/local/jenkins/home/   ##Jenkins目录
PROJECT_NAME=test                       ##Jenkins配置的项目名称
PROJECT_WORKDIR=wwwroot                 ##项目实际生产工作目录
BASE_IMAGE=np                           ##项目运行环境基础镜像

cd ${JENKINS_HOME}/workspace/${PROJECT_NAME}/ 
test -e project.tar.gz ; mv project.tar.gz project-`date +%Y%m%d%H`.tar.gz 
tar zcvf project.tar.gz ${PROJECT_WORKDIR}


###docker_build.sh
##Docker构建项目镜像
set VERSION=v`date +%Y%m%d%H`
docker build -t ${BASE_IMAGE}:${VERSION} .

##标记项目镜像
docker tag ${BASE_IMAGE}:${VERSION} ${DOCKER_REGISTRY}:${DS_PORT}/${BASE_IMAGE}:${VERSION}

##将项目镜像PUSH到Docker仓库
docker push ${DOCKER_REGISTRY}:${DS_PORT}/${BASE_IMAGE}:${VERSION}

##查看上传镜像到Docker仓库是否成功
curl -XGET http://${DOCKER_REGISTRY}:${DS_PORT}/v2/${BASE_IMAGE}/tags/list