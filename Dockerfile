FROM alpine:3.9

RUN addgroup -S mybackup && adduser -S mybackup -G mybackup -s /bin/ash

COPY sshd_config /etc/ssh/sshd_config
COPY  authorized_keys /root/.ssh/authorized_keys
COPY  --chown=mybackup authorized_keys /home/mybackup/.ssh/authorized_keys

RUN chmod 700 /home/mybackup/.ssh && \
    chmod 600 /home/mybackup/.ssh/authorized_keys && \
    echo "mybackup:" | chpasswd

RUN apk add --no-cache \
    bash \
	openssh-server \
	rdiff-backup

RUN mkdir /var/run/sshd

RUN echo 'root:THEPASSWORDYOUCREATED' | chpasswd

RUN /usr/bin/ssh-keygen -A

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-E", "/var/log/auth.log"]
