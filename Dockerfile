FROM centos
RUN mkdir /server/ -p
ADD lnmp.tar.gz /server/
RUN cd /server/lnmp && bash install.sh lnmp && yum install python-setuptools -y && easy_install  pip && pip install supervisor
COPY supervisord.conf /etc/supervisord.conf
RUN /usr/local/nginx/sbin/nginx
EXPOSE 80
CMD supervisord -c /etc/supervisord.conf
