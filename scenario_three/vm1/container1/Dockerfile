FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server netcat vim
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profi
WORKDIR /root
ADD scp.sh /root/scp.sh
ADD config /root/.ssh/config
ADD testfile /root/testfile
RUN chmod 700 scp.sh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
