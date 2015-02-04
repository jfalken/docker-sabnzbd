FROM ubuntu:14.04
MAINTAINER Chris Sandulow <https://github.com/jfalken>

# Add repos for sabnzbdplus
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu trusty main multiverse" >> /etc/apt/sources.list

# Do updates
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python \
      python-dev \
      python-distribute \
      python-pip \
      build-essential \
      supervisor \
      sabnzbdplus

# Where to put blackhole'd nzb files. Map this to a directory on your host.
VOLUME /data

# default port for sickbeard
EXPOSE 8080

# Supervisor will watch the sickbeard process and restart it after updates
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
