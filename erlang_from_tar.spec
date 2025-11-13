Name:	erlang
Version:	23.3.4.20
Release:	1%{?dist}
%global debug_package %{nil}
# Stop RPM from messing with the escript shebangs
%global __brp_mangle_shebangs_exclude_from *
Summary:	Erlang/OTP Programming language runtime

License:	Apache-2.0
URL:	https://www.erlang.org/
Source0:	otp_src_%{version}.tar.gz

%description
Erlang is a programming language used to build massively scalable,
soft real-time systems with high availability requirements.

# This section prepares the source for building. It unpacks Source0 into a clean build directory
%prep
%setup -n otp

# This stage is where we compile Erlang from source. The configure script sets up the Makefiles
# I will install under /usr/local/erlang/%{version}
%build
./configure --prefix=/usr/local/erlang/%{version}
make -j$(nproc)

# This stage installs the built files into a temporary DESTDIR directory %{buildroot} which will later be used to package into the RPM
%install
rm -rf %{buildroot}
make install DESTDIR=%{buildroot}

# This section lists the files and directories which will go into the RPM
%files
/usr/local/erlang/%{version}

