FROM debian:12 AS builder

WORKDIR /build

RUN apt update && apt install -y git build-essential libssl-dev libz-dev fcgiwrap nginx uwsgi

RUN git clone --depth 1 https://git.zx2c4.com/cgit

WORKDIR /build/cgit

RUN git submodule init
RUN git submodule update
RUN make

RUN make install

FROM alpine:3.21

RUN apk update && apk --no-cache --update add nginx python3-dev py3-pip build-base linux-headers pcre-dev uwsgi uwsgi-cgi uwsgi-python3 g++
#RUN pip install uwsgi --break-system-packages

COPY --from=builder /build/cgit/cgit /var/www/htdocs/cgit/cgit.cgi
COPY --from=builder /build/cgit/cgit.js /var/www/htdocs/cgit/cgit.js
COPY --from=builder /build/cgit/cgit.css /var/www/htdocs/cgit/cgit.css
COPY --from=builder /build/cgit/cgit.png /var/www/htdocs/cgit/cgit.png
COPY --from=builder /build/cgit/favicon.ico /var/www/htdocs/cgit/favicon.ico
COPY --from=builder /build/cgit/robots.txt /var/www/htdocs/cgit/robots.txt
COPY --from=builder /build/cgit/filters /usr/local/lib/cgit/filters

COPY configs/nginx.conf /etc/nginx/nginx.conf
COPY configs/cgit.ini /etc/uwsgi/cgit.ini

RUN mkdir /run/uwsgi

COPY repositories /var/www/htdocs/cgit/repositories/

COPY configs/cgitrc /etc/cgitrc

COPY configs/start.sh /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
