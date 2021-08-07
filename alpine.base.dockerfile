FROM alpine:edge

WORKDIR /tmp

RUN  apk update && apk upgrade -U -a \
  && apk --update add ca-certificates --no-cache clang cmake valgrind git openssh vim nano bash\
  && rm -rf /var/cache/apk/*