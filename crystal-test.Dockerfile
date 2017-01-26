FROM ubuntu:14.04.5

RUN apt-get update
RUN apt-get install -y --force-yes apt-file
RUN apt-file update
RUN apt-get install -y --force-yes software-properties-common apt-transport-https
RUN apt-add-repository "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.9 main"
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 09617FD37CC06B54
RUN echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list
RUN apt-get update

RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .bashrc
RUN CONFIGURE_OPTS=--disable-install-doc rbenv install 2.3.3
RUN rbenv global 2.3.3
RUN bash -l -c 'gem install rake --no-document'

RUN apt-get install -y --force-yes automake libtool pkg-config
RUN apt-get install -y --force-yes pkg-config libssl-dev libxml2-dev libyaml-dev libgmp-dev git make
RUN apt-get install -y --force-yes clang-3.9 libclang-3.9-dev llvm-3.9-dev
RUN apt-get install -y --force-yes libevent-dev libpcre3-dev
RUN apt-get install -y --force-yes cmake libcurl4-openssl-dev libssh2-1-dev
RUN echo 'deb https://deb.nodesource.com/node_0.10 trusty main' > /etc/apt/sources.list.d/nodesource.list
RUN echo 'deb-src https://deb.nodesource.com/node_0.10 trusty main' >> /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install -y --force-yes nodejs

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
