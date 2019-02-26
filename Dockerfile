FROM alpine
RUN apk add -U apache2-utils nginx

ENV USER=egeneralov
ENV PASSWD=egeneralov
ENV PROXY_PASS=http://google.com
ENV RESOLVER=8.8.8.8

ADD ./init.sh /
CMD /init.sh
