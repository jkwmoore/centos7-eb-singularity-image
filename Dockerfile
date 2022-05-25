FROM centos:7
LABEL MAINTAINER James Moore <j.k.moore@sheffield.ac.uk>


RUN yum install -y epel-release && \
    yum install -y python3 python3-pip Lmod curl wget git \
        bzip2 gzip tar zip unzip xz \
        patch make git which \
        gcc-c++ perl-Data-Dumper perl-Thread-Queue openssl-dev file

RUN OS_DEPS='' && \
    test -n "${OS_DEPS}" && \
    yum --skip-broken install -y "${OS_DEPS}" || true


RUN pip3 install pip setuptools && \
    hash -r pip3&& \
    pip3 install easybuild

RUN mkdir /app && \
    mkdir /scratch && \
    mkdir /scratch/tmp && \
    useradd -m -s /bin/bash easybuild && \
    chown easybuild:easybuild -R /app && \
    chown easybuild:easybuild -R /scratch

RUN echo 'export MODULEPATH=$MODULEPATH:/app/modules/all' >> /etc/profile

#RUN echo 'module load zlib/1.2.11' >> /etc/profile

USER easybuild

#RUN set -x && . /usr/share/lmod/lmod/init/sh && eb --robot zlib-1.2.11.eb --installpath=/app/ --prefix=/scratch --tmpdir=/scratch/tmp

#RUN rm -rf /scratch/*

CMD ["/bin/bash", "-l"]
