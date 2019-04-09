#!/bin/ash
set -e

# generate host keys, if not exists
/usr/bin/ssh-keygen -A

cp /home/backup/authorized_keys /home/backup/.ssh/authorized_keys
chown -R backup:backup /backup /home/backup/.ssh
chmod 600 /home/backup/.ssh/authorized_keys

exec "$@"
