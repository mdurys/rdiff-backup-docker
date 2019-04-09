FROM alpine:3.9

LABEL maintainer="michal@durys.pl"

RUN addgroup -S backup && \
    adduser -S backup -G backup -s /bin/ash

COPY ./sshd_config /etc/ssh/sshd_config
COPY ./docker-entrypoint.sh /

RUN mkdir /var/run/sshd && \
    mkdir /home/backup/.ssh && \
    chmod 700 /home/backup/.ssh && \
    echo "backup:" | chpasswd

RUN apk add --no-cache \
	openssh-server \
	rdiff-backup

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 22

CMD /usr/sbin/sshd -D -E /var/log/auth.log
