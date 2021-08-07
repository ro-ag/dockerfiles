FROM debian:bullseye-slim

WORKDIR /tmp
# Install basics
COPY chain.crt /usr/local/share/ca-certificates/chain.crt

RUN apt-get update ; apt-get install -y ca-certificates locales wget ; update-ca-certificates \ 
   ; sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
   ; locale-gen \
   ; echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc \
   ; echo "export LANG=en_US.UTF-8" >> ~/.bashrc \ 
   ; echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc \
   ; echo "check_certificate = off" >> ~/.wgetrc \
   ; apt-get clean ; rm -rf /var/lib/apt/lists/*

RUN apt-get install -y apt-utils apt-transport-https \
    git gawk xxd pkg-config libyaml-dev pv libssl-dev\
    build-essential cmake python3 python3-pip lsb-release wget software-properties-common \
    gnupg gnupg2 gnupg1 ninja-build generate-ninja \
    libasan6 liblsan0 libtsan0 libubsan1 valgrind \
    unzip zip autoconf dh-autoreconf locales aptitude curl \
  ; apt-get clean ; rm -rf /var/lib/apt/lists/*

# Get Clang
RUN bash -c "$(wget --no-check-certificate -O - https://apt.llvm.org/llvm.sh)" \ 
  ; cd /usr/local/bin \
  ; ln -s /usr/bin/lldb-12 lldb \
  ; ln -s /usr/bin/lld-12  lld \ 
  ; ln -s /usr/bin/clangd-12 clangd \
  ; ln -s /usr/bin/clang-12 clang

RUN apt-get update & apt-get install -y cpanminus libtask-kensho-all-perl libgetopt-long-descriptive-perl libcatalyst-log-log4perl-perl \
  ; cpanm -i File::chdir Deep::Hash::Utils File::Util IO::Prompter \
  ; apt-get clean ; rm -rf /var/lib/apt/lists/*

# Install Golang

RUN wget --progress=bar:force:noscroll https://golang.org/dl/go1.16.6.linux-amd64.tar.gz \
  ; pv go1.16.6.linux-amd64.tar.gz | tar -C /usr/local -xz \
  ; rm -f go1.16.6.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin
# Install Conan
RUN pip install --no-cache-dir --trusted-host=pypi.org --trusted-host=files.pythonhosted.org conan


RUN GIT_SSL_NO_VERIFY=true git clone https://github.com/rurban/safeclib.git \
    ; cd safeclib; ./build-aux/autogen.sh ; ./configure; make -j ; make check ; make install \
    ; apt-get update


# add Azul's public key
RUN apt-key adv \
  --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys 0xB1998361219BD9C9

# download and install the package that adds 
# the Azul APT repository to the list of sources 
RUN curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-2_all.deb \
  ; apt-get install -y ./zulu-repo_1.0.0-2_all.deb \
  ; apt-get update & apt-get install -y zulu11-jdk-headless zulu11-jre-headless \
  ; apt-get clean \
  ; rm -rf /var/lib/apt/lists/* \
  ; rm -rf *

# install Rust
RUN wget --progress=bar:force:noscroll https://static.rust-lang.org/dist/rust-1.54.0-x86_64-unknown-linux-gnu.tar.gz \
  ; pv rust-1.54.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz \
  ; cd rust-1.54.0-x86_64-unknown-linux-gnu ; ./install.sh --verbose

# Grpc Libraries

RUN GIT_SSL_NO_VERIFY=true git clone --recurse-submodules -b v1.38.0 https://github.com/grpc/grpc
WORKDIR /tmp/grpc

RUN cmake -GNinja -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=OFF \
      . -Bcmake/build ;\
    cd cmake/build; \
    ninja -d stats;\
    ninja install

WORKDIR /tmp/grpc/third_party/abseil-cpp
RUN cmake -GNinja -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE \
    . -Bcmake/build ;\
    cd cmake/build ;\
    ninja -d stats; \
    ninja install

# go grpc

WORKDIR /tmp

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26 \
   ; go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1
ENV PATH="$PATH:$(go env GOPATH)/bin"

SHELL ["/bin/bash", "-c"]

# Kotlin
ENV SDKMAN_DIR=/usr/local/sdkman
RUN rm -rf /var/lib/apt/lists/* \
  ; apt-get update  \ 
  ;  curl -s https://get.sdkman.io | bash \
  ;  chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh" \
  ; source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install kotlin 

RUN apt-get clean \
  & rm -rf /var/lib/apt/lists/* \
  & apt-get update \ 
  & rm -rf * \
  & rm -rf $HOME/.cpanm $HOME/.cache 