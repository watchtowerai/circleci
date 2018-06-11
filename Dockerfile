FROM debian

# Add a vetted trust chain, includes debian and docker trust roots
ADD files/docker-debian.gpg /etc/apt/trusted.gpg.d/

ENV AWSCLI_VERSION=1.11.129
ENV COMPOSE_VERSION=1.17.0

RUN apt update \
    && apt install -y \
    apt-transport-https

ADD files/sources.list /etc/apt/sources.list

RUN apt update && \
    apt install -y \
    curl \
    docker-ce \
    git \
    jq \
    openssh-client \
    python \
    python-pip
RUN python2 -m pip install --upgrade pip \
    && pip install awscli==${AWSCLI_VERSION} docker-compose==${COMPOSE_VERSION}

ADD scripts/ci.sh /usr/bin/ci
ADD scripts/clean_up_reusable_docker.sh /usr/bin/clean_up_reusable_docker
ADD scripts/ensure_head.sh /usr/bin/ensure_head
ADD scripts/push_image_to_ecr.sh /usr/bin/push_image_to_ecr
ADD scripts/print_env.py /usr/bin/print_env
ADD scripts/push_lambda.sh /usr/bin/push_lambda
ADD scripts/wait-for-it.sh /usr/bin/wfi
