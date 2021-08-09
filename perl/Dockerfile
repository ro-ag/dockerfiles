FROM alpine:edge

WORKDIR /tmp

RUN  apk update && apk upgrade -U -a && rm -rf /var/cache/apk/*
RUN  apk update && apk upgrade -U -a && apk add readline readline-dev readline-static perl-inline ncurses perl-term-readkey \
     musl-locales perl-log-log4perl perl-utils coreutils perl-app-cpanminus build-base make automake autoconf gzip curl wget git \ 
     perl-alien-build perl-module-build perl-module-build-xsutil perl-params-util perl-params-validate 	perl-b-cow perl-yaml-libyaml \
     yaml-dev yaml-static yaml perl-http-date perl-http-entity-parser perl-config-autoconf perl-config-tiny perl-module-build-tiny \
     perl-module-build perl-test-yaml perl-test-deep perl-algorithm-diff perl-algorithm-diff-xs perl-spiffy perl-clone perl-io-string \
     perl-class-inspector moreutils perl-list-moreutils perl-xml-tidy perl-dev perl-devel-checklib bash\
  && rm -rf /var/cache/apk/*
# -----------------------
RUN  cpanm -i -q -n Term::ReadLine::Perl \ 
  && cpanm -i -q MCE MCE::Mutex MCE::Signal MCE::Util MCE::Channel MCE::Child MCE::Queue MCE::Relay \
     Array::Utils Module::CoreList Perl::Tidy Modern::Perl Deep::Hash::Utils File::Util \
     CPAN::DistnameInfo Perl::Critic \
  && cpanm -i -q -n IO::Prompter \
     && rm -rf $HOME/.cpanm

RUN cpanm -i -q Task::Kensho::Async && rm -rf $HOME/.cpanm
RUN cpanm -i -q Task::Kensho::Config && rm -rf $HOME/.cpanm
RUN cpanm -i -q Task::Kensho::DBDev && rm -rf $HOME/.cpanm 
RUN cpanm -i -q Task::Kensho::Dates && rm -rf $HOME/.cpanm
RUN cpanm -i -q Task::Kensho::Email && rm -rf $HOME/.cpanm
RUN cpanm -i -q Task::Kensho::ExcelCSV && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::Exceptions && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::Logging && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::OOP && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::Scalability && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::Testing && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::Toolchain && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::WebCrawling && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::WebDev && rm -rf $HOME/.cpanm
RUN cpanm -i -d Task::Kensho::XML && rm -rf $HOME/.cpanm

RUN rm -rf *