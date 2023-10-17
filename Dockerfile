FROM ubuntu

ARG BRANCH="linux-msft-wsl-5.15.y"
RUN apt update \
    && apt install -y \
        bison \
        build-essential \
        dwarves \
        flex \
        git \
        libelf-dev \
        libssl-dev \
        python3-dev \
        python3-pip

RUN git clone https://github.com/microsoft/WSL2-Linux-Kernel.git -b ${BRANCH} --depth 1
WORKDIR /WSL2-Linux-Kernel

# ClientIP-based session affinity
RUN sed -i 's/# CONFIG_NETFILTER_XT_MATCH_RECENT is not set/CONFIG_NETFILTER_XT_MATCH_RECENT=y/' Microsoft/config-wsl

# Cilium support
RUN sed -i 's/# CONFIG_NETFILTER_XT_TARGET_CT is not set/CONFIG_NETFILTER_XT_TARGET_CT=y/' Microsoft/config-wsl
RUN sed -i 's/# CONFIG_NETFILTER_XT_TARGET_TPROXY is not set/CONFIG_NETFILTER_XT_TARGET_TPROXY=y/' Microsoft/config-wsl

# build the kernel
RUN make -j2 KCONFIG_CONFIG=Microsoft/config-wsl
