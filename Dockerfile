FROM docker:17.03.2-ce

RUN apk add --no-cache bash \
                       git \
                       gzip \
                       openssh-client \
                       py-pip \
                       tar \
    && pip install --upgrade pip \
    && pip install docker-compose

ADD ci /usr/bin/ci
ADD wait-for-it.sh /usr/bin/wfi
