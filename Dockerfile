FROM bitnami/minideb:jessie
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    SUDO_FORCE_REMOVE=yes \
    DISPLAY=:0.0

WORKDIR /tmp
ENTRYPOINT ["/usr/bin/sccresearch-sensorlab"]
COPY Installer/sccresearch-sensorlab_1.1-0_i386.deb /tmp/
RUN set -x \
  && dpkg --add-architecture i386 \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends gdebi \
  && gdebi --apt-line ./sccresearch-sensorlab_1.1-0_i386.deb \
  && gdebi --n ./sccresearch-sensorlab_1.1-0_i386.deb \
  && apt-get purge -y gdebi \
  && apt-get autoremove -y \
  && rm -r /var/lib/apt/lists /var/cache/apt/archives

