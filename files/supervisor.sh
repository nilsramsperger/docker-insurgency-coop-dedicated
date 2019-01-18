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

trap term_handler SIGTERM
cd /opt/steam/css
./srcds_linux -console +map "market hunt" +maxplayers 48 & wait ${!}
echo "Insurgency dedicated died"
shutdown