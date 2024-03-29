# OSG Pilot Container

A Docker container build emulating a Syracuse worker node for the OSG VO

This container embeds an OSG pilot and, if provided with valid credentials, connects to the OSG
flock pool.

In order to successfully start payload jobs, two things need to be done:

1. Configure authentication.  Either set the `X509_USER_PROXY` environment variable inside the container
   (using flags to `docker run`) to a volume-mounted grid proxy or bind-mount an authorized host certificate and key
   into `/etc/grid-security/certificates/host{cert,key}.pem`.
2. Set the `OSG_SQUID_LOCATION` environment variable to the HTTP address to a valid Squid location.

Example invocation utilizing a grid proxy:

```
docker run -ti --rm --user osg \
 --cap-add=DAC_OVERRIDE --cap-add=SETUID --cap-add=SETGID --cap-add=SYS_ADMIN --cap-add=SYS_CHROOT --cap-add=SYS_PTRACE \
 -v /cvmfs:/cvmfs \
 -v /path/to/x509:/tmp/x509_user_proxy \
 -e X509_USER_PROXY=/tmp/x509_user_proxy \
 -e OSG_SQUID_LOCATION=http://somehost.syracuse.edu \
 bbockelm/syracuse-osg-container
 ```

Alternately, if you utilize a host certificate,

```
docker run -ti --rm --user osg \
 --cap-add=DAC_OVERRIDE --cap-add=SETUID --cap-add=SETGID --cap-add=SYS_ADMIN --cap-add=SYS_CHROOT --cap-add=SYS_PTRACE \
 -v /cvmfs:/cvmfs \
 -v ~/.globus/syracusecert.pem:/etc/grid-security/hostcert.pem \
 -v ~/.globus/syracusekey.pem:/etc/grid-security/hostkey.pem \
 -e OSG_SQUID_LOCATION=http://somehost.syracuse.edu \
 bbockelm/syracuse-osg-container
 ```
