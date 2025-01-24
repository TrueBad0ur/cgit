FROM debian:12 AS builder

WORKDIR /build

RUN apt update && apt install -y git build-essential libssl-dev libz-dev

RUN git clone https://git.zx2c4.com/cgit

WORKDIR /build/cgit

RUN git submodule init
RUN git submodule update
RUN make

RUN make install

FROM lkwg82/h2o-http2-server
#nginx:1.27.3-perl

COPY configs/cgit.conf /usr/local/apache2/conf/extra/cgit.conf

COPY configs/cgitrc /etc/cgitrc
COPY --from=builder /build/cgit/cgit /cgit/cgit.cgi
COPY --from=builder /build/cgit/cgit.css /cgit/cgit.css
COPY --from=builder /build/cgit/cgit.js /cgit/cgit.js
COPY --from=builder /build/cgit/favicon.ico /cgit/favicon.ico
COPY --from=builder /build/cgit/robots.txt /cgit/robots.txt
COPY --from=builder /build/cgit/cgit.png /cgit/cgit.png
COPY --from=builder /build/cgit/filters/ /cgit/filters/

#COPY configs/cgitrc /etc/cgitrc
#COPY configs/httpd-cgit.conf /etc/httpd/conf.d/httpd-cgit.conf

#RUN chmod +x /var/www/cgi-bin/cgit.cgi

#EXPOSE 80

#CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
