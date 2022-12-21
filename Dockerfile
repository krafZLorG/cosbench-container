FROM ubi8/openjdk-8-runtime:1.14-6.1666624659

ENV COSBENCH_VER="0.4.2.c4"
USER root

ADD rpms /rpms
ADD ${COSBENCH_VER} /cosbench/
COPY docker-entrypoint.sh /

RUN rpm -ivh /rpms/*rpm && rm -rf /rpms
EXPOSE 18088 18089 19088 19089
WORKDIR /cosbench

ENTRYPOINT ["/docker-entrypoint.sh"]
