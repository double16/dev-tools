#!/bin/sh
#
# Initiates Sauce Connect in the background for use by functional testing tools.
# Requires the following environment variables:
# SAUCE_LABS_USER
# SAUCE_LABS_ACCESS_PASSWORD
#
if [ -z "${SAUCE_LABS_USER}" -o -z "${SAUCE_LABS_ACCESS_PASSWORD}" ]; then
	echo "Environment variables SAUCE_LABS_USER and SAUCE_LABS_ACCESS_PASSWORD (aka API key) are required"
	exit 1
fi

mkdir -p ${HOME}/.sc-download || exit $?
cd ${HOME}/.sc-download || exit $?
case $(uname -s) in
Linux)
  SCDIR="sc-4.3-linux"
  SCPKG="sc-4.3-linux.tar.gz"
  ;;
Darwin)
  SCDIR="sc-4.3-osx"
  SCPKG="sc-4.3-osx.zip"
  ;;
esac
[ -f "${SCPKG}" ] || wget -nd https://saucelabs.com/downloads/${SCPKG} || exit $?
case "${SCPKG}" in
*.tar.gz)
  tar xzvfp "${SCPKG}" || exit $?
  ;;
*.zip)
  unzip "${SCPKG}" || exit $?
  ;;
esac
"./${SCDIR}/bin/sc" -u "${SAUCE_LABS_USER}" -k "${SAUCE_LABS_ACCESS_PASSWORD}" -f ${HOME}/.sc-ready &
C=0
while [ ! -f ${HOME}/.sc-ready -a $C -lt 30 ]; do sleep 5s; C=$(($C+1)); done

