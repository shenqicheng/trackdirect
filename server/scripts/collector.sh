#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "$0 [config file] [collector number]"
    exit
fi

CONFIGFILE=$1
COLLECTORNUMBER=$2

if ps -ef | grep -v grep | grep "bin/collector.py $CONFIGFILE $COLLECTORNUMBER" ; then
    exit 0
else
    CURRENTDIR=$(dirname $0)

    sleep 30
    export PYTHONPATH=$PYTHONPATH:$CURRENTDIR/../trackdirect
    cd $CURRENTDIR/../..
    $CURRENTDIR/ogn_devices_install.sh trackdirect db 5432 postgres
    python $CURRENTDIR/../bin/collector.py $CONFIGFILE $COLLECTORNUMBER
    exit 0
fi
