ARG BUILD_FROM
#FROM $BUILD_FROM
FROM resin/rpi-raspbian:stretch

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apt-get update
RUN apt-get install -y jq sox
RUN apt-get install -y alsa-utils

# Install raspotify (librespot wrapper)
RUN curl -sL https://dtcooper.github.io/raspotify/install.sh | sh


COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
