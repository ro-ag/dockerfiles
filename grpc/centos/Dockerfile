FROM centos:8

ARG VERSION=v1.38.0

WORKDIR /tmp

#RUN yum update -y && yum install -y dnf-plugins-core && yum clean
RUN yum --setopt=tsflags=nodocs install -y dnf-plugins-core wget && yum config-manager --set-enabled powertools
RUN yum --setopt=tsflags=nodocs update -q -y && yum clean all

RUN wget --no-check-certificate --progress=bar:force:noscroll \
  https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/e/epel-release-8-11.el8.noarch.rpm \
  && rpm -Uvh epel-release*rpm \
  && dnf install epel-release \
  && yum update -y \
  && yum clean all 

RUN yum --setopt=tsflags=nodocs install -y gcc-toolset-10 \
    cmake git zlib pkg-config autoconf libtool ninja-build \
  && yum clean all 

ENV GRPC_CC_DIR=/usr/local/cc-grpc

# -----------------------
RUN source /opt/rh/gcc-toolset-10/enable \
  && git clone -j 8 --recurse-submodules -b $VERSION https://github.com/grpc/grpc \
  && cd grpc\
  && cmake -GNinja  -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$GRPC_CC_DIR . -Bcmake/build \
  && cd cmake/build \
  && ninja \
  && ninja install \
  && cd /tmp/grpc/third_party/abseil-cpp \
  && cmake -GNinja -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE -DCMAKE_INSTALL_PREFIX=$GRPC_CC_DIR . -Bcmake/build \
  && cd cmake/build \
  && ninja\
  && ninja install \
  && cd /tmp \
  && rm -rf *