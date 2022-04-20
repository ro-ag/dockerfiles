FROM debian:11-slim

ARG VERSION=v1.38.0

WORKDIR /tmp

# Install Toolchains
RUN apt-get update && apt-get install -y -q \
    git pkg-config build-essential cmake ninja-build autoconf libtool \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV GRPC_CC_DIR=/usr/local/cc-grpc

# -----------------------
RUN git clone -j 8 --recurse-submodules -b $VERSION https://github.com/grpc/grpc \
  && cd grpc \
  && cmake -GNinja -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$GRPC_CC_DIR . -Bcmake/build \
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