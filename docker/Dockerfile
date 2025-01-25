FROM debian:12.9-slim AS builder

WORKDIR /build

RUN apt update && apt install -y git build-essential libssl-dev libz-dev wget

RUN git clone --depth 1 https://git.zx2c4.com/cgit

WORKDIR /build/cgit

RUN git submodule init
RUN git submodule update
RUN make

RUN make install

#RUN wget -O cgit.png https://github.com/mrexodia/cgit-theme/blob/b76be44e7a8cfa21376bbaa09f6549f4e41611c6/git-logo.png

FROM debian:12.9-slim

RUN apt update && apt install -y nginx uwsgi

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

#COPY repositories /var/www/htdocs/cgit/repositories/

COPY configs/cgitrc /etc/cgitrc

COPY configs/start.sh /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
