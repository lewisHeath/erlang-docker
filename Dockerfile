FROM redhat/ubi8:latest

WORKDIR /workspace

RUN yum update -y
RUN yum install -y make git sed tar wget curl ncurses-devel openssl-devel gcc
RUN wget https://github.com/erlang/otp/releases/download/OTP-22.3.4.27/otp_src_22.3.4.27.tar.gz
RUN tar -xzvf otp_src_22.3.4.27.tar.gz

ENV ERL_TOP=/workspace/otp_src_22.3.4.27

WORKDIR /workspace/otp_src_22.3.4.27

RUN ./configure --without-javac
RUN make -j18
RUN make install

WORKDIR /root

CMD ["/bin/bash"]
