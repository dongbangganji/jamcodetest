FROM ubuntu/apache2:2.4-22.04_beta
MAINTAINER Carry <lsy1@naver.co.kr>

## 업데이트
RUN apt update
#
## 최신 버전의 패키지 설치를 위한 패키지 설치
RUN apt install software-properties-common -y
#
## PPA-php 설치 (php 8.2 버전 사용을 위해)
RUN add-apt-repository ppa:ondrej/php
## 업데이트
RUN apt-get update
#
## 아래의 설정으로 타임존 설정을 유예하는 것이기 때문에 차후에 따로 설정을 해주어야 합니다.
## php 코어 설치
RUN apt-get install php8.2 -y
RUN apt-get install php8.2-common -y
RUN apt-get install php8.2-cli -y

## php 보편적 모듈 설치
RUN #apt-get install php8.2-bcmath -y
RUN #apt-get install php8.2-bz2 -y
RUN apt-get install php8.2-curl -y
RUN #apt-get install php8.2-gd -y
RUN #apt-get install php8.2-intl -y
#RUN apt-get install php8.2-json -y
RUN apt-get install php8.2-mbstring -y
RUN #apt-get install php8.2-readline -y
RUN #apt-get install php8.2-xml -y
RUN #apt-get install php8.2-zip -y
RUN apt-get install php8.2-pdo-mysql -y
RUN #apt-get install php8.2-dev -y
RUN #apt-get install php8.2-fpm -y
RUN #apt-get install php8.2-imagick -y
RUN apt-get install libapache2-mod-php8.2 -y
RUN #apt-get install php8.2-redis -y
RUN apt-get install vim -y

## 가상 호스트 설정 이미지에 카피
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN mkdir /tmp/session && mkdir /tmp/wsdlcache && mkdir /tmp/xdebug && touch /tmp/xdebug/xdebug-log.log && chmod 777 /tmp/session && chmod 777 /tmp/wsdlcache && chmod 777 /tmp/xdebug

RUN echo session.save_handler = \"files\" >> /etc/php/8.2/apache2/php.ini \
    && echo session.save_path = \"/tmp/session\" >> /etc/php/8.2/apache2/php.ini \
    && echo soap.wsdl_cache_dir = \"/tmp/wsdlcache\" >> /etc/php/8.2/apache2/php.ini \
    && echo short_open_tag = On >> /etc/php/8.2/apache2/php.ini \
    && echo date.timezone = Asia/Seoul >> /etc/php/8.2/apache2/php.ini \
    && echo post_max_size = 100M >> /etc/php/8.2/apache2/php.ini \
    && echo max_input_vars = 100000 >> /etc/php/8.2/apache2/php.ini \
    && echo memory_limit = 516M >> /etc/php/8.2/apache2/php.ini \
    && echo zend_extension = xdebug >> /etc/php/8.2/apache2/php.ini \
    && echo session.auto_start = 1 >> /etc/php/8.2/apache2/php.ini \
    && echo upload_max_filesize=100M >> /etc/php/8.2/apache2/php.ini \
    && echo extension=imagick.so >> /etc/php/8.2/apache2/php.ini \
    && echo extension=redis >> /etc/php/8.2/apache2/php.ini \

    && echo extension=pdo_mysql >> /etc/php/8.2/apache2/php.ini \
    && echo extension=openssl >> /etc/php/8.2/apache2/php.ini \
    && echo extension=mbstring >> /etc/php/8.2/apache2/php.ini \
    && echo extension=gd2 >> /etc/php/8.2/apache2/php.ini \
    && echo extension=imagick.so >> /etc/php/8.2/apache2/php.ini \
    && echo extension=curl >> /etc/php/8.2/apache2/php.ini \

    && echo opcache.enable=1 >> /etc/php/8.2/apache2/php.ini\
    && echo opcache.jit_buffer_size=124M >> /etc/php/8.2/apache2/php.ini\
    && echo opcache.jit=tracing >> /etc/php/8.2/apache2/php.ini

RUN echo zend_extension=xdebug >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.mode=develop,debug >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.cli_color = 1 >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.start_with_request = yes >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.output_dir = \"/tmp/xdebug\" >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.log = \"/tmp/xdebug/xdebug-log.log\" >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.client_host = host.docker.internal >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.client_port = 9003 >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.discover_client_host = false >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.idekey = PHPSTORM >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.trace_output_name = \"trace.%c-%t\" >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.trace_format = 0 >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.collect_return = true >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini \
 && echo xdebug.trace_options = 1 >> /etc/php/8.2/apache2/conf.d/99-xdebug.ini

RUN a2enmod rewrite

EXPOSE 80
