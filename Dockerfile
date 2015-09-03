#Supermetrics front end app
FROM centos:7
MAINTAINER Siim Kaspar Uustalu <siim@mooncascade.com>

#Add Nginx repo to yum
RUN touch /etc/yum.repos.d/nginx.repo \
	&& echo "[nginx]" >> /etc/yum.repos.d/nginx.repo \
	&& echo "name=nginx repo" >> /etc/yum.repos.d/nginx.repo \
	&& echo "baseurl=http://nginx.org/packages/centos/7/x86_64/" >> /etc/yum.repos.d/nginx.repo \
	&& echo "gpgcheck=0" >> /etc/yum.repos.d/nginx.repo \
	&& echo "enabled=1" >> /etc/yum.repos.d/nginx.repo

RUN adduser --system --no-create-home www-data

RUN yum install -y nginx

ADD nginx.conf /etc/nginx/
ADD dist /var/www/superapp

#SPA will be served from here with assets
EXPOSE 8080

WORKDIR /tmp

CMD /usr/sbin/nginx