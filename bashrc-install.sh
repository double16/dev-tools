#!/bin/sh

cat >>"${HOME}/.bashrc" <<EOF
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export PATH=\${PATH}:\${HOME}/node_modules/karma/bin/:\${HOME}/workspace/dev-tools:\${HOME}/node_modules/jshint/bin
alias guard='./grailsw -reloading -Dgrails.nofork=true --echoOut -guard test-app integration:'
EOF

