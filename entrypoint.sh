#!/usr/bin/env bash

PUID=${PUID:-911}
PGID=${PGID:-911}

groupmod -o -g "$PGID" abc
usermod -o -u "$PUID" abc

echo "
───────────────────────────────────────
GID/UID
───────────────────────────────────────
User UID:    $(id -u abc)
User GID:    $(id -g abc)
───────────────────────────────────────
"

chown -R abc:abc /app
chown -R abc:abc /config
chown -R abc:abc /defaults

exec gosu abc "$@"
