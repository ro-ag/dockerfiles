FROM alpine:edge

WORKDIR /tmp

RUN  apk update && apk upgrade -U -a && rm -rf /var/cache/apk/*
RUN  apk update && apk --update add --no-cache ca-certificates cmake wget clang valgrind git openssh openssl \
     vim nano ninja bash pv build-base rust linux-headers python3 py3-pip autoconf automake bzip2 libtool coreutils\
     curl zip unzip make gzip musl-locales\
  && rm -rf /var/cache/apk/*


# Install Go
# -----------------------
COPY --from=golang:rc-alpine /usr/local/go/ /usr/local/go/
ENV PATH=$PATH:/usr/local/go/bin:/usr/local/bin
RUN   go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26 \
   && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1 

# Grpc Libraries
# -----------------------
COPY --from=rodagurto/grpcc:alpine /usr/local/cc-grpc /usr/local/cc-grpc


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

# Install Perl Libraries 
# -----------------------
COPY --from=rodagurto/perl534:alpine /usr/local/perl-534 /usr/local/perl-534
ENV PATH=/usr/local/perl-534/bin:$PATH