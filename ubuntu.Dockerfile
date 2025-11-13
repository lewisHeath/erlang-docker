FROM ubuntu:latest

RUN apt update -y && apt install -y make git sed tar vim wget curl libncurses5-dev libncursesw5-dev build-essential

WORKDIR /root

RUN apt purge -y openssl libssl-dev && \
    wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_amd64.deb && \
    wget http://ftp.us.debian.org/debian/pool/main/o/openssl/openssl_1.1.1w-0+deb11u1_amd64.deb && \
    wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl-dev_1.1.1w-0+deb11u1_amd64.deb && \
    apt install -y ./*ssl*.deb && \
    rm -f ./*ssl*.deb && \
    apt install --reinstall ca-certificates && \
    update-ca-certificates

CMD ["/bin/bash"]

# Notes

# Erlang < OTP-26 requires OpenSSL 1.1.x

# Create the directory structure for building the deb
# https://web.archive.org/web/20250523023319/https://ubuntuforums.org/showthread.php?t=910717
# mkdir -p <project>_<major version>.<minor_version>-<patch_version>/DEBIAN
# e.g. mkdir -p erlang_28.1.1-1/DEBIAN
# Create control file inside DEBIAN directory with relevant metadata
# e.g. touch erlang_28.1.1-1/DEBIAN/control
# Add the following to the control file:Package: otp
# Version: <major_verison>.<minor_version>-<patch_version>
# Section: base
# Priority: optional
# Architecture: amd64
# Maintainer: <name> <email>
# Description: Erlang/OTP Programming Language

# Compile Erlang/OTP from source and copy the compiled files into the directory
# git clone ......
# cd otp
# ./configure --prefix=/usr/local
# make
# make install DESTDIR=/root/<project>_<major version>.<minor_version>-<patch_version>

# To build the deb package:
# dpkg-deb --build <project>_<major version>.<minor_version>-<patch_version>
# e.g. dpkg-deb --build erlang_28.1.1-1