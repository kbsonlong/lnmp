FROM centos
COPY lnmp.tar.gz /
RUN mkdir /server/ -p && cd /server/ && tar zxvf /lnmp.tar.gz && cd lnmp && bash install.sh lnmp && yum install python-setuptools -y && easy_install  pip && pip install supervisor
COPY supervisord.conf /etc/supervisord.conf
RUN /usr/local/nginx/sbin/nginx
EXPOSE 80
CMD supervisord -c /etc/supervisord.conf
