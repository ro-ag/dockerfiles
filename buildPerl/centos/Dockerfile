FROM centos:latest

# Install Toolchains
RUN yum --setopt=tsflags=nodocs install -y dnf-plugins-core wget && yum config-manager --set-enabled powertools -y && dnf install -y glibc-langpack-en \
  && yum --setopt=tsflags=nodocs install -y gcc make git zlib pkg-config autoconf libtool binutils automake openssl \
  && yum clean all 
WORKDIR /tmp

# Install Perl
ENV PATH=/usr/local/perl-534/bin:$PATH
RUN wget --no-check-certificate --progress=bar:force:noscroll http://www.cpan.org/src/5.0/perl-5.34.0.tar.gz\
    && tar -xzf perl-5.34.0.tar.gz \
    && cd perl-5.34.0\
    && ./Configure -s -des -O -Duse64bitall  -Dinc_version_list=none -Dusethreads -Dprefix=/usr/local/perl-534\
    && make -j 8\
    && TEST_JOBS=8 make test_harness\ 
    && make install\
    && rm -rf /tmp/*

## Basic Bundles
RUN curl -L http://cpanmin.us | perl - App::cpanminus\
    && cpanm -i -q Modern::Perl\
    && cpanm -i -q Module::Install::Bundle  Bundle::CPAN  Bundle::Thread \
       Perl::Installed JSON::Validator List::MoreUtils \
       Mozilla::CA Syntax::Collector App::cpanoutdated \
  && rm -rf $HOME/.cpamn 

## Update CPAN packages
RUN cpan-outdated -p | cpanm \
  && rm -rf $HOME/.cpamn \
  && cpanm -i Deep::Hash::Utils File::Util IO::Prompter \
  && rm -rf $HOME/.cpamn
  
# Needed bundles
RUN  cpanm -i Task::Kensho::Async  && rm -rf $HOME/.cpamn \
  && cpanm -i Task::Kensho::CLI  && rm -rf $HOME/.cpamn \
  && cpanm -i Task::Kensho::Dates  && rm -rf $HOME/.cpamn \
  && cpanm -i Task::Kensho::Logging && rm -rf $HOME/.cpamn \
  && cpanm -i Task::Kensho::OOP &&rm -rf $HOME/.cpamn