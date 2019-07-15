
FROM opensciencegrid/osg-wn

RUN yum -y install git python2-condor

RUN cd / && \
    git clone https://github.com/glideinWMS/glideinwms.git

COPY glidein_startup.patch /glideinwms
COPY entrypoint.sh /bin/

RUN cd /glideinwms && \
    patch -p1 < glidein_startup.patch && \
    ./tools/manual_glidein_startup \
        --client-name osg-flock-grid-iu-edu_OSG_gWMSFrontend.main \
        --req-name Glow_US_Syracuse_condor-ce3_whole@gfactory_instance@OSG \
        --wms-collector gfactory-2.opensciencegrid.org \
    > /bin/syracuse_glidein_startup.sh && \
    chmod +x /bin/syracuse_glidein_startup.sh && \
    cp creation/web_base/glidein_startup.sh /bin && \
    chmod +x /bin/glidein_startup.sh

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --batch --verify /tini.asc /tini \
 && chmod +x /tini

ENTRYPOINT ["/tini", "/bin/entrypoint.sh"]

