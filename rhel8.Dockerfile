FROM redhat/ubi8:latest

RUN yum update -y
RUN yum install -y make git sed tar wget curl ncurses-devel openssl-devel gcc gcc-c++ rpm-build

WORKDIR /root

RUN mkdir -p rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

COPY erlang_from_git.spec rpmbuild/SPECS/

# e.g. rpmbuild -ba rpmbuild/SPECS/erlang_from_git.spec -D "mytag OTP-28.1.1" -D "prefix /usr/local" -D "otp_version 28.1.1" -D "erlang_configurations --without-javac"

CMD ["/bin/bash"]
