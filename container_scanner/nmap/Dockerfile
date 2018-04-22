FROM alpine:latest
RUN apk update && apk add nmap
WORKDIR /root
ADD host_to_scan.txt ./host_to_scan.txt
ADD nmap.sh ./nmap.sh
RUN chmod 700 nmap.sh
ENTRYPOINT /bin/sh /root/nmap.sh
