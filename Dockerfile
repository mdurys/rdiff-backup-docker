FROM alpine:3.9

LABEL maintainer="michal@durys.pl"

HEALTHCHECK --interval=5s --timeout=1s --retries=5 CMD ["/docker-healthcheck.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 22

RUN addgroup -S backup && \
    adduser -S backup -G backup -s /bin/ash && \
    echo "backup:" | chpasswd

COPY ./sshd_config /etc/ssh/sshd_config
COPY ./docker-*.sh /

RUN mkdir /var/run/sshd && \
    mkdir /home/backup/.ssh && \
    chmod 700 /home/backup/.ssh

RUN apk add --no-cache \
	openssh-server \
	rdiff-backup

CMD /usr/sbin/sshd -D -E /var/log/auth.log
