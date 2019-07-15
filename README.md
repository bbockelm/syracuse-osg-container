# syracuse-osg-container
A Docker container build emulating a Syracuse worker node for the OSG VO

This container is meant to be used as a way to start a whole node pilot container on a Syracuse node.
It works out of the box but two enviroment variables need to be set up:

1. X509_USER_PROXY a location inside the container where an OSG Flock proxy container is set, for example ('tmp/x509_user_proxy/). 
This proxy needs to have this DN: `/DC=org/DC=incommon/C=US/ST=WI/L=Madison/O=University of Wisconsin-Madison/OU=OCIS/CN=flock.opensciencegrid.org`
1. OSG_SQUID_LOCATION the http address of the squid location at syracuse. For example (http://its-condor-squid1.syr.edu)

So this could be run as
```
docker run -ti --rm --user osg \
 -v /path/to/x509:/tmp/x509_user_proxy \
 -e X509_USER_PROXY=/tmp/x509_user_proxy \
 -e OSG_SQUID_LOCATION=http://somehost.syracuse.edu \
 3f4f25a10341
 ```
 
replace 3f4f25a10341 with the name of the freshly built image)
