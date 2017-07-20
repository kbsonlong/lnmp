1、创建Jenkins用户和用户组
groupadd -g 1000 jenkins
useradd -g 1000 -u 1000 jenkins

2、宿主机创建Jenkins数据存储目录
mkdir /usr/local/jenkins/home -p
chown jenkins.jenkins /usr/local/jenkins/ -R

3、启动
docker run -d -p 9091:8080 -v /usr/local/jenkins/home:/var/jenkins_home --name jenkins --restart="always" jenkins