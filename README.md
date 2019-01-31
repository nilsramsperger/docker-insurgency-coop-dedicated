# Insurgency dedicated server
This image provides an Insurgency dedicated server for cooperative play.

## Work in progress!
This image is work in progress currently. No guarantee it runs properly. But I'm working on it.

## Server properties
* The server is setup for 48 players
* The theaters for _hunt_ and _checkpoint_ are customized for up to 16 human players
* The lobby size is set to 10

## System Requirements
* The server is not contained by the image, to keep it small.
It will download and install on first start of the container.
You will need at least **6GB** of HDD space, for the container to inflate.

## Usage
To start the container run `docker run -d --init --name insurgency-coop-dedicated --restart unless-stopped -v insurgency-coop-dedicated-config:/opt/steam/insurgency/insurgency/cfg -p 27015:27015 -p 27015:27015/udp -p 1200:1200 -p 27005:27005/udp -p 27020:27020/udp -p 26901:26901/udp -e RCON_PASSWORD=mypassword -e INS_PASSWORD=mypassword -e INS_HOSTNAME=myservername nilsramsperger/insurgency-coop-dedicated`.
Change the ENV variables `RCON_PASSWORD`, `INS_PASSWORD` and `INS_HOSTNAME` as you like.

The server's config folder is persisted in the named volume `insurgency-coop-dedicated-config`.
So if you want to change settings, just tap into the container, change the files within config and restart.
The changes won't get lost.