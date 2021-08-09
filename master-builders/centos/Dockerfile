FROM centos:8

WORKDIR /tmp

#RUN yum update -y && yum install -y dnf-plugins-core && yum clean
RUN yum --setopt=tsflags=nodocs install -y dnf-plugins-core wget && yum config-manager --set-enabled powertools
RUN yum --setopt=tsflags=nodocs update -y && yum clean all


RUN wget --no-check-certificate --progress=bar:force:noscroll \
  https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/e/epel-release-8-11.el8.noarch.rpm \
  && rpm -Uvh epel-release*rpm \
  && dnf install epel-release \
  && yum update -y \
  && yum clean all 

# install gcc 
RUN yum --setopt=tsflags=nodocs install -y gcc-toolset-10 gcc-toolset-10-libasan-devel gcc-toolset-10-liblsan-devel \
    gcc-toolset-10-libtsan-devel gcc-toolset-10-libubsan-devel libasan libasan6 liblsan \
    libtsan libubsan libtool pv\
    llvm-toolset \
    wget python3 python3-pip autoconf automake bzip2 git nano zlib \ 
    cpan vim gawk vim-common perl-App-cpanminus perl-Getopt-Long ninja-build valgrind \
  && yum clean all

# Install Go
RUN wget --no-check-certificate --progress=bar:force:noscroll https://golang.org/dl/go1.16.6.linux-amd64.tar.gz \
  && pv -f go1.16.6.linux-amd64.tar.gz | tar -xz \
  && mv go /usr/local \
  && rm -rf *

ENV PATH=$PATH:/usr/local/go/bin

# Install Cmake
RUN wget --no-check-certificate --progress=bar:force:noscroll https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-linux-x86_64.sh \
    && sh cmake-3.21.1-linux-x86_64.sh --skip-license --prefix=/usr/local \
    && rm -rf *

# install Rust
RUN wget --no-check-certificate --progress=bar:force:noscroll https://static.rust-lang.org/dist/rust-1.54.0-x86_64-unknown-linux-gnu.tar.gz \
  && pv -f rust-1.54.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz \
  && cd rust-1.54.0-x86_64-unknown-linux-gnu \
  && ./install.sh --verbose --without=rust-docs\
  && cd .. && rm -rf *

RUN yum --setopt=tsflags=nodocs install -y perl-File-chdir perl-Array-Utils perl-MCE perl-MCE-tools perl-MCE-Shared perl-Module-CoreList \
    perl-DateTime perl-Time-ParseDate perl-Spreadsheet-XLSX perl-DateTime-Format-Excel perl-Spreadsheet-ParseExcel perl-Excel-Writer-XLSX \
    perl-Text-CSV_XS perl-Text-CSV perl-Log-Log4perl perl-Moose perl-Moo perl-MooseX-Types perl-MooX perl-MooseX-Types-Common perl-Type-Tiny\
    perl-Perl-Critic perl-namespace-clean perltidy perl-Module-Build perl-Module-Build-Tiny perl-ExtUtils-CBuilder perl-macros perl-srpm-macros \
    perl-Modern-Perl perl-namespace-autoclean perl-HTTP-Tiny perl-LWP-Protocol-https perl-IO-All \
  && cpanm -i -q Deep::Hash::Utils File::Util IO::Prompter Spreadsheet::Read Log::Any LWP::Simple \
  && rm -rf $HOME/.cpanm \
  && yum clean all

# install Conan Client
RUN pip3 install --no-cache-dir --trusted-host=pypi.org --trusted-host=files.pythonhosted.org conan

# Build safeclib Secure memory library
RUN source /opt/rh/gcc-toolset-10/enable \ 
    && GIT_SSL_NO_VERIFY=true git clone --depth 1 https://github.com/rurban/safeclib.git \
    && cd safeclib \
    && ./build-aux/autogen.sh \
    && ./configure \ 
    && make -j \
    && make check \
    && make install \
    && cd .. \
    && rm -rf *

# Install Zulu 
RUN  yum --setopt=tsflags=nodocs install -y https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm \
  && yum --setopt=tsflags=nodocs install -y zulu11-jdk-headless zulu11-jre-headless && yum clean all

# Install Kotlin
ENV SDKMAN_DIR=/usr/local/sdkman
RUN curl -s https://get.sdkman.io | bash \
  && chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh" \
  && source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install kotlin \
  && rm -rf * 

# Grpc Libraries
RUN source /opt/rh/gcc-toolset-10/enable \
  && GIT_SSL_NO_VERIFY=true git clone -j 4 --recurse-submodules -b v1.38.0 https://github.com/grpc/grpc \
  && cd grpc \
  && cmake -GNinja -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF . -Bcmake/build \
  && cd cmake/build \
  && ninja -d stats \
  && ninja install \
  && cd /tmp/grpc/third_party/abseil-cpp \
  && cmake -GNinja -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE . -Bcmake/build \
  && cd cmake/build \
  && ninja -d stats \
  && ninja install \
  && cd /tmp \
  && rm -rf *

RUN   go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26 \
   && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1 

RUN yum clean all \
  && rm -rf * \
  && rm -rf $HOME/.cpanm $HOME/.cache \
  && rm -fr /var/cache/yum

# Defaults

RUN  echo 'source /opt/rh/gcc-toolset-10/enable' >> /etc/profile.d/go_path.sh \
  && chmod +x /etc/profile.d/go_path.sh ; rm /run/nologin 