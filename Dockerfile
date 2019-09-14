FROM ubuntu:latest
ADD ./files/supervisor.sh /
RUN apt-get update \
    && apt-get install -y wget lib32gcc1 lib32tinfo5 unzip net-tools \
    && wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
    && mkdir -p /opt/steam \
    && tar -C /opt/steam -xvzf /tmp/steamcmd_linux.tar.gz \
    && rm /tmp/steamcmd_linux.tar.gz \
    && chmod +x /supervisor.sh \
    && apt-get remove -y unzip \
    && useradd -ms /bin/bash steam
ADD ./files/ /tmp
EXPOSE 27015/udp
EXPOSE 27015
VOLUME ["/var/insurgency/cfg"]
CMD ["/supervisor.sh"]