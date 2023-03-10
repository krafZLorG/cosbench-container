FROM registry.access.redhat.com/ubi8/openjdk-8-runtime:1.14-6.1666624659

LABEL org.opencontainers.image.source https://github.com/krafZLorG/cosbench-container
USER root

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
    && microdnf --setopt=tsflags=nodocs install -y unzip netcat which patch \
    && microdnf clean all 

COPY cosbench.patch /tmp/
RUN curl -fsSL https://github.com/intel-cloud/cosbench/releases/download/v0.4.2.c4/0.4.2.c4.zip -o /tmp/0.4.2.c4.zip \
    && unzip /tmp/0.4.2.c4.zip -d /tmp \
    && patch -p1 -ruN -d /tmp/0.4.2.c4 -i /tmp/cosbench.patch \
    && rm /tmp/0.4.2.c4/*.bat \
    && mv /tmp/0.4.2.c4 /cosbench \
    && rm -rf /tmp/* 

COPY docker-entrypoint.sh /

EXPOSE 18088 18089 19088 19089
WORKDIR /cosbench

ENTRYPOINT ["/docker-entrypoint.sh"]
