FROM alpine:latest

RUN  apk update && apk upgrade -U -a && rm -rf /var/cache/apk/*
RUN  apk update && apk upgrade -U -a && apk add readline readline-dev readline-static ncurses\
     musl-locales make automake autoconf gzip curl wget git build-base gcc zlib zlib-static zlib-dev\ 
     yaml pv bash linux-headers openssl openssl-dev libpthread-stubs\
  && rm -rf /var/cache/apk/*

WORKDIR /tmp
ENV PATH=/usr/local/perl-534/bin:$PATH
RUN wget --no-check-certificate --progress=bar:force:noscroll http://www.cpan.org/src/5.0/perl-5.34.0.tar.gz\
    && pv -f perl-5.34.0.tar.gz | tar -xz\
    && cd perl-5.34.0\
    && ./Configure -s -des -O -Duse64bitall  -Dinc_version_list=none -Dusethreads -Dprefix=/usr/local/perl-534\
    && make -j 8\
    && TEST_JOBS=8 make test_harness\ 
    && make install\
    && rm -rf /tmp/*

## Good Bundles
RUN curl -L http://cpanmin.us | perl - App::cpanminus\
    && cpanm -i -q Modern::Perl\
    && cpanm -i -q Module::Install::Bundle  Bundle::CPAN  Bundle::Thread \
    Perl::Installed JSON::Validator List::MoreUtils \
    Mozilla::CA Syntax::Collector \
  && rm -rf $HOME/.cpamn

RUN cpanm -i -q Amiga::ARexx Amiga::Exec AnyDBM_File App::Cpan\
    App::Prove App::Prove::State App::Prove::State::Result App::Prove::State::Result::Test\
    Archive::Tar Archive::Tar::File Attribute::Handlers AutoLoader AutoSplit\
    B B::Concise B::Deparse B::Op_private B::Showlex B::Terse B::Xref\
    Benchmark IO::Socket::IP Socket CPAN \
 && rm -rf $HOME/.cpamn

RUN cpanm -i -q CPAN::Debug CPAN::Distroprefs CPAN::FirstTime CPAN::HandleConfig CPAN::Kwalify\
  CPAN::Meta CPAN::Meta::Converter CPAN::Meta::Feature CPAN::Meta::History CPAN::Meta::Merge CPAN::Meta::Prereqs\
  CPAN::Meta::Requirements CPAN::Meta::Spec CPAN::Meta::Validator CPAN::Meta::YAML CPAN::Nox CPAN::Plugin\
  CPAN::Plugin::Specfile CPAN::Queue CPAN::Tarzip CPAN::Version Carp Class::Struct Compress::Raw::Bzip2\
  Compress::Raw::Zlib Compress::Zlib Config::Extensions Config::Perl::V Cwd DBM_Filter DBM_Filter::compress\
  DBM_Filter::encode DBM_Filter::int32 DBM_Filter::null DBM_Filter::utf8 Data::Dumper Devel::PPPort Devel::Peek\
  Devel::SelfStubber Digest Digest::MD5 Digest::SHA Digest::base Digest::file DirHandle Dumpvalue DynaLoader\
  Encode Encode::Alias Encode::Byte Encode::CJKConstants Encode::CN Encode::CN::HZ Encode::Config Encode::EBCDIC\
  Encode::Encoder Encode::Encoding Encode::GSM0338 Encode::Guess Encode::JP Encode::JP::H2Z Encode::JP::JIS7\
  Encode::KR Encode::KR::2022_KR Encode::MIME::Header Encode::MIME::Name \
  && rm -rf $HOME/.cpamn

RUN cpanm -i -q Encode::Symbol\
  Encode::TW\
  Encode::Unicode\
  Encode::Unicode::UTF7\
  English\
  Env\
  Errno\
  Exporter\
  Exporter::Heavy\
  ExtUtils::CBuilder\
  ExtUtils::CBuilder::Platform::Windows\
  ExtUtils::Command\
  ExtUtils::Command::MM\
  ExtUtils::Constant\
  ExtUtils::Constant::Base\
  ExtUtils::Constant::Utils\
  ExtUtils::Constant::XS\
  ExtUtils::Embed\
  ExtUtils::Install\
  ExtUtils::Installed\
  ExtUtils::Liblist\
  ExtUtils::MM\
  ExtUtils::MM_AIX\
  ExtUtils::MM_Any\
  ExtUtils::MM_BeOS\
  ExtUtils::MM_Cygwin\
  ExtUtils::MM_DOS\
  ExtUtils::MM_Darwin\
  ExtUtils::MM_MacOS\
  ExtUtils::MM_NW5\
  ExtUtils::MM_OS2\
  ExtUtils::MM_OS390\
  ExtUtils::MM_QNX\
  ExtUtils::MM_UWIN\
  ExtUtils::MM_Unix\
  ExtUtils::MM_VMS\
  ExtUtils::MM_VOS\
  ExtUtils::MM_Win32\
  ExtUtils::MM_Win95\
  ExtUtils::MY\
  ExtUtils::MakeMaker\
  ExtUtils::MakeMaker::Config\
  ExtUtils::MakeMaker::Locale\
  ExtUtils::Manifest\
  ExtUtils::Miniperl\
  ExtUtils::Mkbootstrap\
  ExtUtils::Mksymlists\
  ExtUtils::PL2Bat\
  ExtUtils::Packlist\
  ExtUtils::ParseXS\
  ExtUtils::ParseXS::Constants\
  ExtUtils::ParseXS::Eval\
  ExtUtils::ParseXS::Utilities\
  ExtUtils::Typemaps\
  ExtUtils::Typemaps::Cmd\
  ExtUtils::Typemaps::InputMap\
  ExtUtils::Typemaps::OutputMap\
  ExtUtils::Typemaps::Type\
  ExtUtils::XSSymSet\
  ExtUtils::testlib \
  && rm -rf $HOME/.cpamn

RUN cpanm -i -q Fatal\
  Fcntl\
  File::Basename\
  File::Compare\
  File::Copy\
  File::DosGlob\
  File::Fetch\
  File::Find\
  File::Glob\
  File::GlobMapper\
  File::Path\
  File::Spec\
  File::Spec::AmigaOS\
  File::Spec::Cygwin\
  File::Spec::Epoc\
  File::Spec::Functions\
  File::Spec::Mac\
  File::Spec::OS2\
  File::Spec::Unix\
  File::Spec::VMS\
  File::Spec::Win32\
  File::Temp\
  File::stat\
  FileCache\
  FileHandle\
  Filter::Simple\
  Filter::Util::Call\
  FindBin\
  GDBM_File\
  Getopt::Long\
  Getopt::Std\
  HTTP::Tiny\
  Hash::Util\
  Hash::Util::FieldHash\
  I18N::Collate\
  I18N::LangTags\
  I18N::LangTags::Detect\
  I18N::LangTags::List\
  I18N::Langinfo\
  IO\
  IO::Compress::Base\
  IO::Compress::Bzip2\
  IO::Compress::Deflate\
  IO::Compress::Gzip\
  IO::Compress::RawDeflate\
  IO::Compress::Zip\
  IO::Dir\
  IO::File\
  IO::Handle\
  IO::Pipe\
  IO::Poll\
  IO::Seekable\
  IO::Select\
  IO::Socket\
  IO::Socket::INET\
  IO::Socket::UNIX\
  IO::Uncompress::AnyInflate\
  IO::Uncompress::AnyUncompress\
  IO::Uncompress::Base\
  IO::Uncompress::Bunzip2\
  IO::Uncompress::Gunzip\
  IO::Uncompress::Inflate\
  IO::Uncompress::RawInflate\
  IO::Uncompress::Unzip\
  IO::Zlib\
  IPC::Cmd\
  IPC::Msg\
  IPC::Open2\
  IPC::Open3\
  IPC::Semaphore\
  IPC::SharedMem\
  IPC::SysV \
  && rm -rf $HOME/.cpamn

RUN cpanm -i -q Internals\
  JSON::PP\
  JSON::PP::Boolean\
  List::Util\
  List::Util::XS\
  Locale::Maketext\
  Locale::Maketext::Guts\
  Locale::Maketext::GutsLoader\
  Locale::Maketext::Simple\
  MIME::Base64\
  MIME::QuotedPrint\
  Math::BigFloat\
  Math::BigInt\
  Math::BigInt::Calc\
  Math::BigInt::FastCalc\
  Math::BigInt::Lib\
  Math::BigRat\
  Math::Complex\
  Math::Trig\
  Memoize\
  Memoize::AnyDBM_File\
  Memoize::Expire\
  Memoize::ExpireFile\
  Memoize::ExpireTest\
  Memoize::NDBM_File\
  Memoize::SDBM_File\
  Memoize::Storable\
  Module::CoreList\
  Module::CoreList::Utils\
  Module::Load\
  Module::Load::Conditional\
  Module::Loaded\
  Module::Metadata\
  NDBM_File\
  NEXT\
  Net::Cmd\
  Net::Config\
  Net::Domain\
  Net::FTP\
  Net::FTP::dataconn\
  Net::NNTP\
  Net::Netrc\
  Net::POP3\
  Net::Ping\
  Net::SMTP\
  Net::Time\
  Net::hostent\
  Net::netent\
  Net::protoent\
  Net::servent \
  && rm -rf $HOME/.cpamn

RUN cpanm -i -q   O\
  ODBM_File\
  Opcode\
  POSIX\
  Params::Check\
  Parse::CPAN::Meta\
  Perl::OSType\
  PerlIO\
  PerlIO::encoding\
  PerlIO::mmap\
  PerlIO::scalar\
  PerlIO::via\
  PerlIO::via::QuotedPrint\
  Pod::Checker\
  Pod::Escapes\
  Pod::Functions\
  Pod::Html\
  Pod::Man\
  Pod::ParseLink\
  Pod::Perldoc\
  Pod::Perldoc::BaseTo\
  Pod::Perldoc::GetOptsOO\
  Pod::Perldoc::ToANSI\
  Pod::Perldoc::ToChecker\
  Pod::Perldoc::ToMan\
  Pod::Perldoc::ToNroff\
  Pod::Perldoc::ToPod\
  Pod::Perldoc::ToRtf\
  Pod::Perldoc::ToTerm\
  Pod::Perldoc::ToText\
  Pod::Perldoc::ToTk\
  Pod::Perldoc::ToXml\
  Pod::Simple\
  Pod::Simple::Checker\
  Pod::Simple::Debug\
  Pod::Simple::DumpAsText\
  Pod::Simple::DumpAsXML\
  Pod::Simple::HTML\
  Pod::Simple::HTMLBatch\
  Pod::Simple::JustPod\
  Pod::Simple::LinkSection\
  Pod::Simple::Methody\
  Pod::Simple::PullParser\
  Pod::Simple::PullParserEndToken\
  Pod::Simple::PullParserStartToken\
  Pod::Simple::PullParserTextToken\
  Pod::Simple::PullParserToken\
  Pod::Simple::RTF\
  Pod::Simple::Search\
  Pod::Simple::SimpleTree\
  Pod::Simple::Text\
  Pod::Simple::TextContent\
  Pod::Simple::XHTML\
  Pod::Simple::XMLOutStream\
  Pod::Text\
  Pod::Text::Color\
  Pod::Text::Overstrike\
  Pod::Text::Termcap\
  Pod::Usage \
  && rm -rf $HOME/.cpamn

RUN cpanm -i -q SDBM_File\
   Safe\
  Scalar::Util\
  Search::Dict\
  SelectSaver\
  SelfLoader\
  Storable\
  Sub::Util\
  Symbol\
  Sys::Hostname\
  Sys::Syslog\
  Sys::Syslog::Win32\
  TAP::Base\
  TAP::Formatter::Base\
  TAP::Formatter::Color\
  TAP::Formatter::Console\
  TAP::Formatter::Console::ParallelSession\
  TAP::Formatter::Console::Session\
  TAP::Formatter::File\
  TAP::Formatter::File::Session\
  TAP::Formatter::Session\
  TAP::Harness\
  TAP::Harness::Env\
  TAP::Object\
  TAP::Parser\
  TAP::Parser::Aggregator\
  TAP::Parser::Grammar\
  TAP::Parser::Iterator\
  TAP::Parser::Iterator::Array\
  TAP::Parser::Iterator::Process\
  TAP::Parser::Iterator::Stream\
  TAP::Parser::IteratorFactory\
  TAP::Parser::Multiplexer\
  TAP::Parser::Result\
  TAP::Parser::Result::Bailout\
  TAP::Parser::Result::Comment\
  TAP::Parser::Result::Plan\
  TAP::Parser::Result::Pragma\
  TAP::Parser::Result::Test\
  TAP::Parser::Result::Unknown\
  TAP::Parser::Result::Version\
  TAP::Parser::Result::YAML\
  TAP::Parser::ResultFactory\
  TAP::Parser::Scheduler\
  TAP::Parser::Scheduler::Job\
  TAP::Parser::Scheduler::Spinner\
  TAP::Parser::Source\
  TAP::Parser::SourceHandler\
  TAP::Parser::SourceHandler::Executable\
  TAP::Parser::SourceHandler::File\
  TAP::Parser::SourceHandler::Handle\
  TAP::Parser::SourceHandler::Perl\
  TAP::Parser::SourceHandler::RawTAP\
  TAP::Parser::YAMLish::Reader\
  TAP::Parser::YAMLish::Writer\
  Term::ANSIColor\
  Term::Cap\
  Term::Complete\
  Term::ReadLine \
  && rm -rf $HOME/.cpamn

RUN cpanm -i -q Test\
  Test2\
  Test2::API\
  Test2::API::Breakage\
  Test2::API::Context\
  Test2::API::Instance\
  Test2::API::InterceptResult\
  Test2::API::InterceptResult::Event\
  Test2::API::InterceptResult::Hub\
  Test2::API::InterceptResult::Squasher\
  Test2::API::Stack\
  Test2::Event\
  Test2::Event::Bail\
  Test2::Event::Diag\
  Test2::Event::Encoding\
  Test2::Event::Exception\
  Test2::Event::Fail\
  Test2::Event::Generic\
  Test2::Event::Note\
  Test2::Event::Ok\
  Test2::Event::Pass\
  Test2::Event::Plan\
  Test2::Event::Skip\
  Test2::Event::Subtest\
  Test2::Event::TAP::Version\
  Test2::Event::V2\
  Test2::Event::Waiting\
  Test2::EventFacet\
  Test2::EventFacet::About\
  Test2::EventFacet::Amnesty\
  Test2::EventFacet::Assert\
  Test2::EventFacet::Control\
  Test2::EventFacet::Error\
  Test2::EventFacet::Hub\
  Test2::EventFacet::Info\
  Test2::EventFacet::Info::Table\
  Test2::EventFacet::Meta\
  Test2::EventFacet::Parent\
  Test2::EventFacet::Plan\
  Test2::EventFacet::Render\
  Test2::EventFacet::Trace\
  Test2::Formatter\
  Test2::Formatter::TAP\
  Test2::Hub\
  Test2::Hub::Interceptor\
  Test2::Hub::Interceptor::Terminator\
  Test2::Hub::Subtest\
  Test2::IPC\
  Test2::IPC::Driver\
  Test2::IPC::Driver::Files\
  Test2::Tools::Tiny\
  Test2::Util\
  Test2::Util::ExternalMeta\
  Test2::Util::Facets2Legacy\
  Test2::Util::HashBase\
  Test2::Util::Trace\
  Test::Builder\
  Test::Builder::Formatter\
  Test::Builder::IO::Scalar\
  Test::Builder::Module\
  Test::Builder::Tester\
  Test::Builder::Tester::Color\
  Test::Builder::TodoDiag\
  Test::Harness\
  Test::More\
  Test::Simple\
  Test::Tester\
  Test::Tester::Capture\
  Test::Tester::CaptureRunner\
  Test::use::ok\
  Text::Abbrev\
  Text::Balanced\
  Text::ParseWords\
  Text::Tabs\
  Text::Wrap \
  && rm -rf $HOME/.cpamn

RUN cpanm -i -q Thread\
  Thread::Queue\
  Thread::Semaphore\
  Tie::Array\
  Tie::File\
  Tie::Handle\
  Tie::Hash\
  Tie::Hash::NamedCapture\
  Tie::Memoize\
  Tie::RefHash\
  Tie::Scalar\
  Tie::StdHandle\
  Tie::SubstrHash\
  Time::HiRes\
  Time::Local\
  Time::Piece\
  Time::Seconds\
  Time::gmtime\
  Time::localtime\
  Time::tm\
  UNIVERSAL\
  Unicode::Collate\
  Unicode::Collate::CJK::Big5\
  Unicode::Collate::CJK::GB2312\
  Unicode::Collate::CJK::JISX0208\
  Unicode::Collate::CJK::Korean\
  Unicode::Collate::CJK::Pinyin\
  Unicode::Collate::CJK::Stroke\
  Unicode::Collate::CJK::Zhuyin\
  Unicode::Collate::Locale\
  Unicode::Normalize\
  Unicode::UCD\
  User::grent\
  User::pwent\
  VMS::DCLsym\
  VMS::Filespec\
  VMS::Stdio\
  XS::APItest\
  XS::Typemap\
  XSLoader\
  autodie::Scope::Guard\
  autodie::Scope::GuardStack\
  autodie::Util\
  && rm -rf $HOME/.cpamn

RUN cpanm -i Task::Kensho::Async  &&rm -rf $HOME/.cpamn
RUN cpanm -i -q Task::Kensho::CLI  &&rm -rf $HOME/.cpamn
RUN cpanm -i -q Task::Kensho::Dates  &&rm -rf $HOME/.cpamn
RUN cpanm -i -q Task::Kensho::Logging &&rm -rf $HOME/.cpamn
RUN cpanm -i Task::Kensho::OOP &&rm -rf $HOME/.cpamn