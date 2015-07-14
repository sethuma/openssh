FROM centos:centos6
RUN yum update -y
RUN yum install -y openssh-server sudo

RUN  /etc/init.d/sshd start

RUN useradd admin -G wheel
RUN echo 'admin:secret' | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

RUN mkdir -p /home/admin/.ssh
ADD authorized_keys /home/admin/.ssh/
RUN chown -R admin:admin /home/admin/.ssh; chmod 700 /home/admin/.ssh

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
