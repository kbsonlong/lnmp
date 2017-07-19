FROM centos
RUN mkdir /server/ -p
ADD lnmp.tar.gz /server/
RUN yum install python-setuptools -y && easy_install  pip && pip install supervisor  -i http://mirrors.aliyun.com/pypi/simple  --trusted-host mirrors.aliyun.com
RUN cd /server/lnmp && bash install.sh lnmp
COPY supervisord.conf /etc/supervisord.conf
RUN /usr/local/nginx/sbin/nginx
CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
EXPOSE 80
ONBUILD ADD project.tar.gz  /home/
ONBUILD CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]