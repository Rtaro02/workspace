FROM ubuntu:22.04

RUN apt-get update && apt-get install -y openssh-server git vim wget curl sudo

ARG GIT_USER
ARG GIT_PASSWORD
RUN git clone https://github.com/Rtaro02/provision-myenvironment.git
RUN cd provision-myenvironment && bash provision.sh ${GIT_USER} ${GIT_PASSWORD}
RUN mkdir /var/run/sshd

ARG ROOT_PASSWORD
RUN echo root:${ROOT_PASSWORD} | chpasswd

RUN sed -i 's/#\?PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
