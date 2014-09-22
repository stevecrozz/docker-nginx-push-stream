FROM ubuntu:trusty

ADD nginx-push-stream-module /src/nginx-push-stream-module
ADD nginx /src/nginx

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y build-dep nginx
RUN \
  cd /src/nginx && \
  ./configure --add-module=../nginx-push-stream-module && \
  make
RUN \
  cd /src/nginx && \
  make install

CMD /usr/local/nginx/sbin/nginx -g 'daemon off;'
EXPOSE 80
EXPOSE 443
