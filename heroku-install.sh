#!/bin/sh -x

DIR="${HOME}/heroku-client"
mkdir "${DIR}" || exit 1
wget -O - http://assets.heroku.com/heroku-client/heroku-client.tgz | tar xz -C "${DIR}"
cat >>"${HOME}/.bashrc" <<EOF
export PATH=${PATH}:${HOME}/heroku-client/bin
EOF

