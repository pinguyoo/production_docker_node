#!/bin/bash
set -eu

if [ -z "$GROUP_ID" ] || [ -z "$USER_ID" ]; then
  echo >&2 "ERROR: GROUP_ID / USER_ID is unset"
  exit 1
fi

addgroup -g $GROUP_ID user
adduser -u $USER_ID user -D -G user

exec su-exec user "$@"