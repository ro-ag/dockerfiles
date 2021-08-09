FROM alpine:latest

WORKDIR /tmp

ARG VERSION=v1.38.0

RUN apk update && apk upgrade -U -a && apk add git build-base ninja cmake autoconf libtool pkgconfig && rm -rf /var/cache/apk/*

ENV GRPC_CC_DIR=/usr/local/cc-grpc

# -----------------------
RUN git clone -j 4 --recurse-submodules -b $VERSION https://github.com/grpc/grpc \
  && cd grpc \
  && cmake -GNinja -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$GRPC_CC_DIR . -Bcmake/build \
  && cd cmake/build \
  && ninja \
  && ninja install \
  && cd /tmp/grpc/third_party/abseil-cpp \
  && cmake -GNinja -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE -DCMAKE_INSTALL_PREFIX=$GRPC_CC_DIR . -Bcmake/build \
  && cd cmake/build \
  && ninja \
  && ninja install \
  && cd /tmp \
  && rm -rf *