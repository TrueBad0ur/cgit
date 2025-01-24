FROM debian:12 AS builder

WORKDIR /build

RUN apt update && apt install -y git build-essential libssl-dev libz-dev lighttpd

RUN git clone --depth 1 https://git.zx2c4.com/cgit

WORKDIR /build/cgit

RUN git submodule init
RUN git submodule update
RUN make

RUN make install

#FROM rtsp/lighttpd

#RUN mkdir -p /usr/local/lib/cgit/filters

#COPY --from=builder /build/cgit/cgit /var/www/htdocs/cgit/cgit.cgi
#COPY --from=builder /build/cgit/cgit.js /var/www/htdocs/cgit/cgit.js
#COPY --from=builder /build/cgit/cgit.css /var/www/htdocs/cgit/cgit.css
#COPY --from=builder /build/cgit/cgit.png /var/www/htdocs/cgit/cgit.png
#COPY --from=builder /build/cgit/favicon.ico /var/www/htdocs/cgit/favicon.ico
#COPY --from=builder /build/cgit/robots.txt /var/www/htdocs/cgit/robots.txt
#COPY --from=builder /build/cgit/filters /usr/local/lib/cgit/filters

COPY configs/cgit.conf /etc/lighttpd/lighttpd.conf

#COPY configs/cgit.conf /etc/lighttpd/conf.d/cgit.conf
#RUN echo 'include "conf.d/cgit.conf"' >> /etc/lighttpd/lighttpd.conf

ENTRYPOINT ["/usr/sbin/lighttpd"]

CMD ["-D", "-f", "/etc/lighttpd/lighttpd.conf"]