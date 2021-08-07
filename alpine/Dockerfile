FROM alpine:edge

WORKDIR /tmp

RUN  apk update && apk upgrade -U -a && rm -rf /var/cache/apk/*
RUN  apk update && apk --update add --no-cache ca-certificates cmake wget clang valgrind git openssh openssl \
     vim nano ninja bash pv build-base rust linux-headers python3 py3-pip autoconf automake bzip2 libtool coreutils\
     curl zip unzip \
  && rm -rf /var/cache/apk/*


# Install Go
# -----------------------
COPY --from=golang:rc-alpine /usr/local/go/ /usr/local/go/
ENV PATH=$PATH:/usr/local/go/bin:/usr/local/bin

# Grpc Libraries
# -----------------------
RUN git clone -j 4 --recurse-submodules -b v1.38.0 https://github.com/grpc/grpc \
  && cd grpc \
  && cmake -GNinja -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF . -Bcmake/build \
  && cd cmake/build \
  && ninja \
  && ninja install \
  && cd /tmp/grpc/third_party/abseil-cpp \
  && cmake -GNinja -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE . -Bcmake/build \
  && cd cmake/build \
  && ninja \
  && ninja install \
  && cd /tmp \
  && rm -rf *

RUN   go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26 \
   && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1 

# add Azul's public key
# -----------------------
RUN  wget -P /etc/apk/keys/ https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub \
  && echo "https://repos.azul.com/zulu/alpine" | tee -a /etc/apk/repositories \
  && apk update \
  && apk --update add --no-cache zulu11-jdk\
  && rm -rf /var/cache/apk/*

# Install Kotlin
# -----------------------
ENV SDKMAN_DIR=/usr/local/sdkman
RUN curl -s https://get.sdkman.io | bash
RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install kotlin" && rm -rf *

# install Conan Client
# -----------------------
RUN pip3 install --no-cache-dir --trusted-host=pypi.org --trusted-host=files.pythonhosted.org conan

# Get Perl Libraries
# -----------------------
RUN apk update && apk --update add --no-cache perl perl-utils perl-app-cpanminus perl-moose \
  perl-datetime perl-time-parsedate perl-spreadsheet-xlsx perl-spreadsheet-parseexcel \
  perl-text-csv_xs perl-text-csv perl-log-log4perl perl-moose perl-moo perl-moosex-types perl-moosex-types-common perl-type-tiny \ 
  perl-namespace-clean perl-module-build perl-module-build-tiny \ 
  perl-namespace-autoclean perl-lwp-protocol-https \
  && rm -rf /var/cache/apk/*

# Install Perl Libraries # bad Perl::Critic IO::Prompter
# -----------------------
RUN  cpanm -i -q MCE MCE::Mutex MCE::Signal MCE::Util MCE::Channel MCE::Child MCE::Queue MCE::Relay \
     Array::Utils Module::CoreList Perl::Tidy Modern::Perl Deep::Hash::Utils File::Util Task::Kensho::ExcelCSV \
     && rm -rf $HOME/.cpanm