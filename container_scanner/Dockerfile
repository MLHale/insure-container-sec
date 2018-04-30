FROM ubuntu:16.04
RUN apt-get update
RUN apt-get -y install python
RUN apt-get clean
WORKDIR /outputs
CMD ["/usr/bin/python", "-m",  "SimpleHTTPServer", "8000"]

