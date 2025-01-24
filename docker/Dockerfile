FROM debian:12 AS builder

WORKDIR /build

RUN apt update && apt install -y git build-essential libssl-dev libz-dev fcgiwrap nginx uwsgi

RUN git clone --depth 1 https://git.zx2c4.com/cgit

WORKDIR /build/cgit

RUN git submodule init
RUN git submodule update
RUN make

RUN make install

#FROM rtsp/lighttpd

#RUN mkdir -p /usr/local/lib/cgit/filters

#COPY --from=builder /build/cgit/cgit /usr/share/webapps/cgit/cgit.cgi
#COPY --from=builder /build/cgit/cgit.js /usr/share/webapps/cgit/cgit.js
#COPY --from=builder /build/cgit/cgit.css /usr/share/webapps/cgit/cgit.css
#COPY --from=builder /build/cgit/cgit.png /usr/share/webapps/cgit/cgit.png
#COPY --from=builder /build/cgit/favicon.ico /usr/share/webapps/cgit/favicon.ico
#COPY --from=builder /build/cgit/robots.txt /usr/share/webapps/cgit/robots.txt
#COPY --from=builder /build/cgit/filters /usr/local/lib/cgit/filters

COPY configs/nginx.conf /etc/nginx/nginx.conf
COPY configs/cgit.ini /etc/uwsgi/cgit.ini

RUN mkdir /run/uwsgi

COPY repositories /var/www/htdocs/cgit/repositories/

COPY configs/cgitrc /etc/cgitrc

COPY start.sh /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]