FROM quay.io/centos/centos:stream9

# Install basic packages
RUN dnf -y update && \
    dnf -y install sudo which bc xz make bzip2 unzip diffutils \
           git cpio patch info util-linux dnf-plugins-core

# Enable EPEL and EPEL-next
RUN dnf config-manager --set-enabled crb && \
    dnf install -y epel-release epel-next-release

# Install additional packages
RUN dnf -y install rpmdevtools

# Copy additional repo config files
COPY eballetbo.repo /etc/yum.repos.d

# Install packages for u-boot
RUN dnf -y install bison dtc flex gcc gnutls-devel libuuid-devel \
                   ncurses-devel openssl-devel perl-interpreter \
                   python3-devel python3-setuptools python3-libfdt \
                   SDL2-devel swig

# Install packages for u-boot on arm64
RUN dnf -y install arm-trusted-firmware-armv8	gcc-arm-linux-gnu \
                   optee-os-firmware-armv8 python3-jsonschema \
	                 python3-pyelftools	python3-pyyaml ti-firmware

# RUN dnf -y install redhat-rpm-config
# RUN dnf -y install redhat-release
# RUN dnf -y install rpm-build
# RUN dnf -y install epel-rpm-macros

# Copy host setup script to be run during installation
COPY hostsetup.sh /usr/local/bin/hostsetup.sh

# copy entry point
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Copy some helpful build scripts
RUN mkdir -p /usr/share/uboot
COPY ubuild.sh /usr/share/uboot

WORKDIR /app

RUN groupadd -r --gid 1000 blduser && \
    useradd --uid 1000 --gid blduser --home-dir /app blduser

# Temporary to speed up container development - add apt install
RUN echo "blduser ALL= NOPASSWD: /usr/bin/dnf" > /etc/sudoers.d/blduser && \
    chmod 0440 /etc/sudoers.d/blduser

# Setup env for xxx builds

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
