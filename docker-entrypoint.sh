#!/bin/sh

mkdir /byond
chown $RUNAS:$RUNAS /byond /StoneBay baystation12.rsc

gosu $RUNAS DreamDaemon baystation12.dmb 8000 -trusted -verbose
