FROM nginx:1.17.9

RUN apt-get update && apt-get -y upgrade && apt-get install -y \
spawn-fcgi \ 
fcgiwrap \
mariadb-client \
unzip \
imagemagick \
perlmagick \
libgd-perl \
libcache-memcached-perl \
libarchive-zip-perl \
libauthen-sasl-perl \
libcrypt-dsa-perl \
libio-socket-ssl-perl \
libxml-atom-perl \
libxml-sax-perl \
libyaml-syck-perl \ 
libxml-sax-expatxs-perl \
build-essential \
amazon-efs-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 80

STOPSIGNAL SIGTERM

COPY docker-entrypoint.sh /
COPY fcgiwrap.conf /etc/nginx/
RUN mkdir /usr/share/nginx/html/cgi-bin
RUN chmod 755 /usr/share/nginx/html/cgi-bin
#COPY mt-check.cgi /usr/share/nginx/html/cgi-bin/
#RUN chmod 777 /usr/share/nginx/html/cgi-bin/mt-check.cgi
#COPY hello.cgi /usr/share/nginx/html/cgi-bin/
#RUN chmod 777 /usr/share/nginx/html/cgi-bin/hello.cgi
COPY mt.zip /usr/share/nginx/html/cgi-bin/
RUN unzip /usr/share/nginx/html/cgi-bin/mt.zip -d '/usr/share/nginx/html/cgi-bin/'
RUN chmod 777 /usr/share/nginx/html/cgi-bin/mt
COPY mt-config.cgi /usr/share/nginx/html/cgi-bin/mt
RUN chmod 777 /usr/share/nginx/html/cgi-bin/mt/mt-static/support
RUN chmod 777 /usr/share/nginx/html

RUN chmod +x /docker-entrypoint.sh
COPY default.conf /etc/nginx/conf.d/
ENTRYPOINT ["/docker-entrypoint.sh"]


