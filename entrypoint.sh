#!/bin/sh

if [ -e /etc/grid-security/hostkey.pem ]; then

  cp /etc/grid-security/hostcert.pem /tmp/hostcert.pem
  chmod 0644 /tmp/hostcert.pem
  cp /etc/grid-security/hostkey.pem /tmp/hostkey.pem
  chmod 0600 /tmp/hostkey.pem

  grid-proxy-init \
    -cert /tmp/hostcert.pem \
    -key /tmp/hostkey.pem \
    -hours 168 \
    -out /tmp/x509_pilot_proxy || exit 1

  rm -f /tmp/hostcert.pem /tmp/hostkey.pem

  export X509_USER_PROXY=/tmp/x509_pilot_proxy

fi

cd /tmp
export _CONDOR_SCRATCH_DIR=$PWD
exec syracuse_glidein_startup.sh
