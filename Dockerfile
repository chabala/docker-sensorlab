# retrieving the software (deb inside a tarball inside a zip, with spaces in the names, ugh)
FROM alpine:3.13.5 AS zipfile
ADD http://ccgi.dcpmicro.plus.com/dcplogit/files/software/linuxSensorlab.zip .
RUN apk add --no-cache unzip tar \
  && unzip linuxSensorlab.zip \
  && tar -xzf SensorLab\ 1-1-0\ for\ Linux.tgz

# using minideb as a debian base image https://github.com/bitnami/minideb
FROM bitnami/minideb:jessie
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    DISPLAY=:0.0

WORKDIR /tmp
ENTRYPOINT ["/usr/bin/sccresearch-sensorlab"]
COPY --from=zipfile ["SensorLab 1-1-0 for Linux/Installer/sccresearch-sensorlab_1.1-0_i386.deb", "/tmp/"]
RUN set -x \
  && dpkg --add-architecture i386 \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends gcc-4.9-base:i386 init-system-helpers krb5-locales libatk1.0-0:i386 libavahi-client3:i386 libavahi-common-data:i386 libavahi-common3:i386 libbsd0:i386 libc6-i686:i386 libc6:i386 libcairo2:i386 libcomerr2:i386 libcups2:i386 libdatrie1:i386 libdbus-1-3:i386 libexpat1:i386 libffi6:i386 libfontconfig1:i386 libfreetype6:i386 libgcc1:i386 libgdk-pixbuf2.0-0:i386 libglib2.0-0:i386 libglib2.0-data libgmp10:i386 libgnutls-deb0-28:i386 libgraphite2-3:i386 libgssapi-krb5-2:i386 libgtk2.0-0:i386 libgtk2.0-bin libharfbuzz0b:i386 libhogweed2:i386 libice6:i386 libjasper1:i386 libjbig0:i386 libjpeg62-turbo:i386 libk5crypto3:i386 libkeyutils1:i386 libkrb5-3:i386 libkrb5support0:i386 liblzma5:i386 libnettle4:i386 libp11-kit0:i386 libpango-1.0-0:i386 libpango1.0-0:i386 libpangocairo-1.0-0:i386 libpangoft2-1.0-0:i386 libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 libpcre3:i386 libpixman-1-0:i386 libpng12-0:i386 libselinux1:i386 libsm6:i386 libstdc++6:i386 libtasn1-6:i386 libthai0:i386 libtiff5:i386 libuuid1:i386 libx11-6:i386 libxau6:i386 libxcb-render0:i386 libxcb-shm0:i386 libxcb1:i386 libxcomposite1:i386 libxcursor1:i386 libxdamage1:i386 libxdmcp6:i386 libxext6:i386 libxfixes3:i386 libxft2:i386 libxi6:i386 libxinerama1:i386 libxrandr2:i386 libxrender1:i386 libxxf86vm1:i386 uuid-runtime x11-common xdg-user-dirs zlib1g:i386 \
  && dpkg -i ./sccresearch-sensorlab_1.1-0_i386.deb \
  && rm -r /var/lib/apt/lists /var/cache/apt/archives

