FROM alpine:3.15

# # Install Toolchains
RUN  apk update && apk upgrade -U -a && rm -rf /var/cache/apk/*
RUN  apk update && apk upgrade -U -a && apk add readline readline-dev readline-static ncurses\
     musl-locales make automake autoconf gzip curl wget git build-base gcc\ 
     yaml pv bash linux-header zlib \
  && rm -rf /var/cache/apk/*

# openssl openssl-dev libpthread-stubs 

# Build Perl
WORKDIR /tmp

ENV PATH=/usr/local/perl-534/bin:$PATH
ARG JOBS=4
RUN wget --no-check-certificate --progress=bar:force:noscroll http://www.cpan.org/src/5.0/perl-5.34.0.tar.gz\
    && pv -f perl-5.34.0.tar.gz | tar -xz\
    && cd perl-5.34.0\
    && ./Configure -s -des -O -Duse64bitall  -Dinc_version_list=none -Dusethreads -Dprefix=/usr/local/perl-534\
    && make -j $JOBS
RUN  cd perl-5.34.0\   
    && TEST_JOBS=$JOBS make test_harness\ 
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
