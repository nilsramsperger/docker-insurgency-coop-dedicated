#!/usr/bin/env bash

shutdown() {
    kill ${!}
    echo "Container stopped"
    exit 143;
}

term_handler() {
    echo "SIGTERM received"
    shutdown
}

install() {
    echo "Installing Insurgency Dedicated Server"
    /opt/steam/steamcmd.sh +login anonymous +force_install_dir /opt/steam/insurgency +app_update 237410 validate +quit
    mkdir /opt/steam/insurgency/insurgency/scripts
    [ ! -f /opt/steam/insurgency/insurgency/cfg/persisted.cfg ] \
    && cp -a /tmp/cfg/. /opt/steam/insurgency/insurgency/cfg/ \
    && touch /opt/steam/insurgency/insurgency/cfg/persisted.cfg
    cp -a /tmp/scripts/. /opt/steam/insurgency/insurgency/scripts/
    rm -r /tmp/
    chown -R steam:steam /opt/steam/insurgency
    echo "Installation done"
}

trap term_handler SIGTERM
[ ! -d "/opt/steam/insurgency/insurgency/scripts" ] && install
echo "Starting Insurgency Dedicated Server"
cd /opt/steam/insurgency
su steam
export LD_LIBRARY_PATH=/opt/steam/insurgency:/opt/steam/insurgency/bin:{$LD_LIBRARY_PATH}
./srcds_linux -console +sv_lan 0 +servercfgfile server.cfg +map "market hunt" +maxplayers 48 & wait ${!}
echo "Insurgency Dedicated Server died"
shutdown