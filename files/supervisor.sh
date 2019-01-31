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
    sudo /opt/steam/steamcmd.sh +login anonymous +force_install_dir /opt/steam/ +app_update 237410 validate +quit
    mv /tmp/cfg /opt/steam/insurgency
    mv /tmp/scripts /opt/steam/insurgency
    rm /tmp/
    chown -R steam:steam /opt/steam/insurgency
    echo "Installation done"
}

trap term_handler SIGTERM
[ ! -d "/opt/steam/insurgency" ] && install
echo "Starting Insurgency Dedicated Server"
cd /opt/steam/insurgency
./srcds_linux -console +sv_lan 0 +servercfgfile server.cfg +map "market hunt" +maxplayers 48 & wait ${!}
echo "Insurgency Dedicated Server died"
shutdown