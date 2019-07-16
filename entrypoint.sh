#!/bin/sh

if [ -e /etc/grid-security/hostkey.pem ]; then

  grid-proxy-init \
    -cert /etc/grid-security/hostcert.pem \
    -key /etc/grid-security/hostkey.pem \
    -hours 168 \
    -out /tmp/x509_pilot_proxy || exit 1

  export X509_USER_PROXY=/tmp/x509_pilot_proxy

fi

cd /tmp
export _CONDOR_SCRATCH_DIR=$PWD
exec syracuse_glidein_startup.sh
