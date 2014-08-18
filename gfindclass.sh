#!/bin/sh

if [ -z "$1" ]; then
	echo "Expecting class name(s)"
	exit 1
fi

GRAILS_VER="$(grep app.grails.version application.properties|cut -d '=' -f 2)"
APP_NAME="$(grep app.name application.properties|cut -d '=' -f 2)"
GRAILS_DIR="${HOME}/.grails/wrapper/${GRAILS_VER}/grails-${GRAILS_VER}"
APP_DIR="$(pwd)/target/plugins"

find ${GRAILS_DIR} ${APP_DIR} -iname "*.jar" | while read JAR; do
	for CLASS in $@; do

	unzip -v "${JAR}" | grep "/${CLASS}\.class"

	done
done | tr -s "[:space:]" | cut -d " " -f 9 | sort | uniq | sed -e 's/\.class$//' -e 's/\//./g' -e 's/^/import /'

