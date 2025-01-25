FROM alpine:3.21

RUN apk update && apk --no-cache --update add nginx python3-dev py3-pip build-base linux-headers pcre-dev uwsgi-cgi
RUN pip install uwsgi --break-system-packages

COPY nginx.conf /etc/nginx/nginx.conf
COPY cgit.ini /etc/uwsgi/cgit.ini

RUN mkdir /run/uwsgi

COPY start.sh /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
