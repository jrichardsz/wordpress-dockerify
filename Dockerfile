FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

## just php 7.1

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update -y

RUN apt-get install -y apache2
RUN apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-cli php7.1-common php7.1-mbstring php7.1-gd php7.1-intl php7.1-xml php7.1-mysql php7.1-mcrypt php7.1-zip


RUN php -v

## copy custom wordpress code

RUN mkdir -p /var/www/html
COPY . /var/www/html

WORKDIR /var/www/html

## configure apache

# remove ubuntu apache default page
RUN rm /var/www/html/index.html

ENV CUSTOM_DOCUMENT_ROOT=\/var\/www\/html

# fix warning
# AH00558: apache2: Could not reliably determine the server's fully qualified domain name,
# using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN echo "<Directory $CUSTOM_DOCUMENT_ROOT>" >> /etc/apache2/apache2.conf
RUN echo "    Options Indexes FollowSymLinks" >> /etc/apache2/apache2.conf
RUN echo "    AllowOverride All" >> /etc/apache2/apache2.conf
RUN echo "    Require all granted" >> /etc/apache2/apache2.conf
RUN echo "</Directory>" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite

# final docker configuration

COPY DockerfileEntryPoint.sh /usr/local/bin/DockerfileEntryPoint.sh
RUN chmod 744 /usr/local/bin/DockerfileEntryPoint.sh

ENTRYPOINT ["DockerfileEntryPoint.sh", "apache2-foreground"]
