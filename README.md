# 持续迭代发布

持续部署流程

![image](/images/Flow_Chart.png)

1、开发提交代码到git服务器，通过钩子触发Jenkins执行构建；

2、Jenkins将代码打包，并通过Dockerfile执行build构建镜像；

3、镜像构建成功之后，将镜像PUSH到Docker仓库；

4、通过测试服务器pull新版镜像部署，调用测试服务接口，检测服务是否正常；

5、通过salt-api发送指令到生产环境，进行分发部署。需要安装<	
SaltStack plugin>插件