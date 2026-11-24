FROM ubuntu:24.04

# 使用非交互模式运行，避免在构建过程中出现交互提示
ARG DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的工具和软件包
RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    locales \
    ca-certificates \
    curl \
    dnsutils \
    iputils-ping \
    jq \
    mysql-client \
    net-tools \
    postgresql-client \
    redis-tools \
    telnet \
    vim \
    wget \
    openssh-client \
    xz-utils \
    tcpdump \
    nmap \
    unzip \
  && rm -rf /var/lib/apt/lists/* \
  && case "$(uname -m)" in \
    x86_64) aws_arch="x86_64" ;; \
    aarch64) aws_arch="aarch64" ;; \
    *) echo "unsupported architecture: $(uname -m)" >&2 && exit 1 ;; \
  esac \
  && curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${aws_arch}.zip" -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && echo "complete -C '/usr/local/bin/aws_completer' aws" >> /etc/bash.bashrc \
  && rm -rf awscliv2.zip aws \
  && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
