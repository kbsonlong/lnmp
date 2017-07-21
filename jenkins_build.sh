#!/bin/bash
# Name   :  jenkins_build.sh
# Author :  蜷缩的蜗牛
# Site   :  www.along.party
# Version:  V0.1
# Info   :  打包项目代码，构建docker镜像，push镜像到docker仓库

source /usr/local/jenkins/home/scripts/config.ini
source /usr/local/jenkins/home/scripts/.version.ini

echo "VERSION=${VERSION}" >${JENKINS_HOME}scripts/.version.ini           ##固化版本信息，避免脚本执行是由于时间点改变，VERSION变量引用错误
echo $VERSION
cd ${JENKINS_HOME}/workspace/${PROJECT_NAME}/
test -e project.tar.gz ; mv project.tar.gz project-`date +%Y%m%d%H`.tar.gz
tar zcvf project.tar.gz ${PROJECT_WORKDIR}


###docker_build.sh
##Docker构建项目镜像

cd ${JENKINS_HOME}/workspace/${PROJECT_NAME}/
docker build -t ${BASE_IMAGE}:${VERSION} .

##标记项目镜像
docker tag ${BASE_IMAGE}:${VERSION} ${DOCKER_REGISTRY}:${DS_PORT}/${BASE_IMAGE}:${VERSION}

##将项目镜像PUSH到Docker仓库
docker push ${DOCKER_REGISTRY}:${DS_PORT}/${BASE_IMAGE}:${VERSION}

##查看上传镜像到Docker仓库是否成功
curl -XGET http://${DOCKER_REGISTRY}:${DS_PORT}/v2/${BASE_IMAGE}/tags/list