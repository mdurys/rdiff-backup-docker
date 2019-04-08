#!/bin/ash
set -e

cp /home/backup/authorized_keys /home/backup/.ssh/authorized_keys
chown -R backup:backup /backup
chown -R backup:backup /home/backup/.ssh
chmod 600 /home/backup/.ssh/authorized_keys

exec "$@"
