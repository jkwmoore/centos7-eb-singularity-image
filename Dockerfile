FROM centos:7
LABEL maintainer=easybuild@lists.ugent.be


RUN yum install -y epel-release && \
    yum install -y python3 python3-pip Lmod curl wget git \
        bzip2 gzip tar zip unzip xz \
        patch make git which file \
        gcc-c++ perl-Data-Dumper perl-Thread-Queue openssl-dev

RUN OS_DEPS='' && \
    test -n "${OS_DEPS}" && \
    yum --skip-broken install -y "${OS_DEPS}" || true

RUN yum clean all

RUN pip3 install -U pip setuptools && \
    hash -r pip3&& \
    pip3 install -U easybuild

RUN mkdir /app && \
    mkdir /scratch && \
    mkdir /scratch/tmp && \
    useradd -m -s /bin/bash easybuild && \
    chown easybuild:easybuild -R /app && \
    chown easybuild:easybuild -R /scratch

USER easybuild

CMD ["/bin/bash", "-l"]