FROM centos:7
MAINTAINER niwa3

RUN yum -y update && yum clean all
RUN yum install -y sudo

RUN yum -y groupinstall base "Development Tools" --setopt=group_package_types=mandantory,default,optional
RUN yum install -y kernel-devel kernel-headers
RUN yum install -y lua-devel ncurses-devel perl-ExtUtils-Embed tmux python2 python-devel libevent libevent-devel

WORKDIR /root/
RUN curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
RUN wget https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_amd64.tar.gz
RUN tar -xzf peco_linux_amd64.tar.gz
RUN rm -rf peco_linux_amd64.tar.gz
RUN git clone https://github.com/vim/vim.git
RUN curl -kLO https://github.com/tmux/tmux/releases/download/2.7/tmux-2.7.tar.gz
RUN tar -xzvf tmux-2.7.tar.gz
RUN git clone https://github.com/tmux-plugins/tpm ./.tmux/plugins/tpm

WORKDIR /root/vim
RUN yum autoremove -y vim \
    && make distclean \
    && ./configure --prefix=/usr/local/ --with-features=huge --enable-multibyte --enable-luainterp --enable-pythoninterp --with-python-command=/bin/python2 --with-python-config-dir=/lib64/python2.7/config/ --enable-cscope --enable-fail-if-missing \
    && make \
    && make install

WORKDIR /root/tmux-2.7
RUN ./configure \
    && make \
    && make install

WORKDIR /root/
COPY ./config/.bashrc /root/
COPY ./config/.vimrc /root/
COPY ./config/.tmux.conf /root/

CMD sh /root/installer.sh /root/.vim/dein ; /bin/bash
