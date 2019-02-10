#!/usr/bin/env bash

loadConfig() {
    yes | cp -rfa /var/insurgency/cfg/. /opt/steam/insurgency/insurgency/cfg/
}

storeConfig() {
    yes | cp -rfa /opt/steam/insurgency/insurgency/cfg/. /var/insurgency/cfg/
}

shutdown() {
    kill ${!}
    storeConfig
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
    cp -a /tmp/cfg/. /opt/steam/insurgency/insurgency/cfg/
    mkdir /opt/steam/insurgency/insurgency/scripts
    cp -a /tmp/scripts/. /opt/steam/insurgency/insurgency/scripts/
    rm -r /tmp/
    chown -R steam:steam /opt/steam/insurgency
    echo "Installation done"
}

trap term_handler SIGTERM
[ ! -d "/opt/steam/insurgency" ] && install
su steam
loadConfig
echo "Starting Insurgency Dedicated Server"
cd /opt/steam/insurgency
export LD_LIBRARY_PATH=/opt/steam/insurgency:/opt/steam/insurgency/bin:{$LD_LIBRARY_PATH}
./srcds_linux -console +sv_lan 0 +servercfgfile server.cfg +map "market hunt" +maxplayers 48 & wait ${!}
echo "Insurgency Dedicated Server died"
shutdown