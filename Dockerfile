FROM alpine:latest

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
	&& apk add --update --no-cache \
		bash \
		bats \
		curl \
		py2-pip \
	&& pip install \
		boto3 \
		pymemcache \
		pymongo \
		PyMySQL==0.8.1 \
		pg8000 \
		redis \
		awscli

RUN mkdir -p /usr/src/await/bin /usr/src/await/test
WORKDIR /usr/src/await

COPY bin /usr/src/await/bin/
COPY test /usr/src/await/test/

ENV PATH /usr/src/await/bin:$PATH

CMD [ "await", "--help" ]
