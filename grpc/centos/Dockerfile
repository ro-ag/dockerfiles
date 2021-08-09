FROM centos:8

ARG VERSION=v1.38.0

WORKDIR /tmp

RUN yum update && yum groupinstall -y 'Development Tools' && yum install -y cmake ninja git  && yum clean all 

ENV GRPC_CC_DIR=/usr/local/cc-grpc

# -----------------------
RUN git clone -j 4 --recurse-submodules -b $VERSION https://github.com/grpc/grpc \
  && cd grpc \
  && cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$GRPC_CC_DIR . -Bcmake/build \
  && cd cmake/build \
  && make -j \
  && make install \
  && cd /tmp/grpc/third_party/abseil-cpp \
  && cmake -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE -DCMAKE_INSTALL_PREFIX=$GRPC_CC_DIR . -Bcmake/build \
  && cd cmake/build \
  && make -j\
  && make install \
  && cd /tmp \
  && rm -rf *