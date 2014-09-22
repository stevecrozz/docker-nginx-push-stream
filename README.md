docker-nginx-push-stream
========================
A build script and Dockerfile for nginx that includes the
[nginx-push-stream-module](https://github.com/wandenberg/nginx-push-stream-module).

## Example

Provide configuration to the docker image by mapping a volume that contains an
nginx.conf file onto the guest. To run the nginx process, run
```/usr/local/nginx/sbin/nginx``` and pass a -c flag with the path to
nginx.conf.

Note: You must specify daemon 'off' in your nginx.conf

```bash
docker run -d -i -t \
  --name nginx \
  -p 80:80 \
  -v /vagrant/etc/nginx:/etc/nginx \
  -v /vagrant/var/log/nginx:/var/log/nginx \
  "stevecrozz/nginx-push-stream:master" \
  /usr/local/nginx/sbin/nginx -c /etc/nginx/nginx.conf
```

## Building

If you want to build the image yourself, just run ```./build```
