Name:	erlang
Version:	%{otp_version}
Release:	1%{?dist}
Summary:	Erlang/OTP Programming language runtime
License:	Apache-2.0
URL:	https://www.erlang.org/

%{!?prefix: %global prefix /usr/local/erlang/%{version}}
%{!?mytag: %global mytag OTP-23.3.4.20}

%global debug_package %{nil}
# Stop RPM from messing with the escript shebangs
%global __brp_mangle_shebangs_exclude_from *

%description
Erlang is a programming language used to build massively scalable,
soft real-time systems with high availability requirements.

# This section prepares the source for building. It unpacks Source0 into a clean build directory
%prep
echo "==> Cleaning previous source if exists"
rm -rf otp
echo "==> Cloning Erlang/OTP %{mytag} from GitHub"
git clone --branch %{mytag} --depth 1 https://github.com/erlang/otp.git

# This stage is where we compile Erlang from source. The configure script sets up the Makefiles
# I will install under /usr/local/erlang/%{version}
%build
cd otp
echo "==> Configuring Erlang with prefix %{prefix}"
./configure --prefix=%{prefix}
make -j$(nproc)

# This stage installs the built files into a temporary DESTDIR directory %{buildroot} which will later be used to package into the RPM
%install
echo "==> Installing into %{buildroot}"
cd otp
rm -rf %{buildroot}
make install DESTDIR=%{buildroot}

# This section lists the files and directories which will go into the RPM
%files
%{prefix}

