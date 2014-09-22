FROM ubuntu:trusty

ADD nginx-push-stream-module /src/nginx-push-stream-module
ADD nginx /src/nginx

RUN apt-get update
RUN \
  dpkg --get-selections | grep -v deinstall | awk '{print $1}' | sort > /tmp/initial-packages && \
  DEBIAN_FRONTEND=noninteractive apt-get -y build-dep nginx && \
  cd /src/nginx && \
  ./configure --add-module=../nginx-push-stream-module && \
  make && \
  cd /src/nginx && \
  make install && \
  dpkg --get-selections | grep -v deinstall | awk '{print $1}' | sort > /tmp/final-packages && \
  DEBIAN_FRONT_END=noninteractive apt-get -y purge `comm -13 /tmp/initial-packages /tmp/final-packages`

CMD /usr/local/nginx/sbin/nginx -g 'daemon off;'
EXPOSE 80
EXPOSE 443
