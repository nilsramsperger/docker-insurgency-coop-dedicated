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
    sudo /opt/steam/steamcmd.sh +login anonymous +force_install_dir /opt/steam/ +app_update 237410 validate +quit
    mv /tmp/cfg /opt/steam/insurgency
    mv /tmp/scripts /opt/steam/insurgency
    rm /tmp/
    chown -R steam:steam /opt/steam/insurgency
}

trap term_handler SIGTERM
cd /opt/steam/insurgency
[ ! -d "/opt/steam/insurgency" ] && install
./srcds_linux -console +sv_lan 0 +servercfgfile server.cfg +map "market hunt" +maxplayers 48 & wait ${!}
echo "Insurgency dedicated died"
shutdown