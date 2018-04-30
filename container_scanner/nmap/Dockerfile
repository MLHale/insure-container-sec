FROM alpine:latest
RUN apk update && apk add nmap
WORKDIR /root
ADD host_to_scan.txt /root/host_to_scan.txt
ADD nmap.sh /root/nmap.sh
RUN chmod 700 /root/nmap.sh
ENTRYPOINT /bin/sh /root/nmap.sh
