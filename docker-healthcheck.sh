#!/bin/ash
set -e

netstat -tulpn | egrep "LISTEN\s+\d+/sshd" || exit 1

exit 0
