FROM ubuntu:18.04
MAINTAINER OEMS "oemunoz@co.ibm.com"
#ENV TZ=America/Bogota

RUN echo 'Acquire::http::Proxy "http://172.23.33.39:8000/";' >> /etc/apt/apt.conf
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
          DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 \
                     gzip rsync graphviz sqlite3 libjpeg-turbo8-dev \
                     libpng-dev php-sqlite3 php-gettext php-curl    \ 
                     libfreetype6-dev openssl libapache2-mod-php

ADD http://www.nagvis.org/share/nagvis-1.9.8.tar.gz /

RUN tar -zxvf /nagvis-1.9.8.tar.gz && cd /nagvis-1.9.8 && \
    ./install.sh -q -p /usr/local/nagvis -l "tcp:icinga:6558" -b mklivestatus -u www-data -g www-data -w /etc/apache2/conf-available -a y && \
    cp /nagvis-1.9.8/nagvis-make-admin /usr/local/nagvis/etc/ && \
    printf "nagvis:$(openssl passwd -crypt changeme)\n" >> /etc/apache2/htpasswd.users

ADD nagvis.conf /etc/apache2/conf-available/nagvis.conf
ADD nagvis.ini.php /usr/local/nagvis/etc/nagvis.ini.php
RUN ln -s /etc/apache2/conf-available/nagvis.conf /etc/apache2/conf-enabled/nagvis.conf

CMD /usr/sbin/apache2ctl -D FOREGROUND
