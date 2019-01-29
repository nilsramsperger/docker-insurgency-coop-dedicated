#!/usr/bin/env bash

shutdown() {
    kill ${!}
    echo "Stopped"
    exit 143;
}

term_handler() {
    echo "SIGTERM received"
    shutdown
}

install() {
    /opt/steam/steamcmd.sh +login anonymous +force_install_dir /opt/steam/insurgency/ +app_update 237410 validate +quit
    mv /opt/steam/temp/cfg /opt/steam/insurgency
    mv /opt/steam/temp/scripts /opt/steam/insurgency
    chown -R steam:steam /opt/steam/insurgency
}

trap term_handler SIGTERM
cd /opt/steam/insurgency
[ ! -d "/opt/steam/insurgency/scripts" ] && install
./srcds_linux -console +sv_lan 0 +servercfgfile server.cfg +map "market hunt" +maxplayers 48 & wait ${!}
echo "Insurgency dedicated died"
shutdown