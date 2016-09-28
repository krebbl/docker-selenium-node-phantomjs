FROM debian:wheezy
MAINTAINER Marcus Krejpowicz
ENV PHANTOMJS_VERSION 2.1.1

USER root
RUN echo "deb http://gce_debian_mirror.storage.googleapis.com wheezy contrib non-free" >> /etc/apt/sources.list \
  && echo "deb http://gce_debian_mirror.storage.googleapis.com wheezy-updates contrib non-free" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org/ wheezy/updates contrib non-free" >> /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y dist-upgrade

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula \
    select true | debconf-set-selections

RUN apt-get install --no-install-recommends -y -q  \
    tar wget unzip bzip2 xvfb xauth bbe \
    libfontconfig \
    ttf-kochi-gothic ttf-kochi-mincho ttf-mscorefonts-installer \
    ttf-indic-fonts ttf-dejavu-core fonts-thai-tlwg

WORKDIR /tmp
RUN wget --no-check-certificate -q -O - https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 | tar xjC /opt
RUN ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

RUN bbe /usr/bin/phantomjs -b "/\x70\x6C\x61\x74\x66\x6F\x72\x6D\x3A\x20\x67\x68/:/\x63\x74\x75\x72\x65\x2C\x0A/" -e "f 0 \x20" -o phantomjs_patched
RUN mv phantomjs_patched /usr/bin/phantomjs
RUN chmod 755 /usr/bin/phantomjs
RUN apt-get autoremove -y
RUN apt-get clean all


ADD join-hub.sh /usr/local/phantomjs/

ENTRYPOINT [ "sh", "-c", "/usr/local/phantomjs/join-hub.sh" ]
