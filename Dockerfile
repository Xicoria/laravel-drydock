FROM ubuntu:artful
MAINTAINER "Alexander Trauzzi" <atrauzzi@gmail.com>

WORKDIR /var/www

RUN apt-get update -y
RUN apt-get install -y \
	curl \
	git \
	mercurial \
	python \
	python-setuptools \
	php7.1-pgsql \
	php7.1-sqlite \
	php-redis \
	php7.1-json \
	php7.1-mcrypt \
	php7.1-zip \
	php7.1-curl \
	php7.1-gd \
	php7.1-fpm \
	php7.1-dom \
	php7.1-bcmath \
	php7.1-mbstring \
	php7.1-cli

RUN easy_install pip

RUN phpenmod mcrypt

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pip install hg+https://bitbucket.org/dbenamy/devcron#egg=devcron

RUN touch /var/log/cron.log

COPY /resources/artisan /usr/local/bin/artisan
RUN chmod +x /usr/local/bin/artisan

RUN chmod 777 /run
RUN chmod 770 /home

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm7.1"]
CMD ["-F", "-R"]
