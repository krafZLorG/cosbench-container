#!/bin/bash

if [ -z "$1" ]; then
    echo "No argument supplied"
    echo "Controller and driver will be started"
    echo "-------------------------------------"
    echo "You can provide driver or controller as argument"
    echo "-------------------------------------"
    sh start-all.sh
elif [ "$1" = "controller" ]; then
    sh start-controller.sh
elif [ "$1" = "driver" ]; then
    sh start-driver.sh
else
    echo "Incorrect argument"
    echo "------------------------------------------------"
    echo "You can provide driver or controller as argument"
    echo "------------------------------------------------"
    exit 1
fi

while true
do
    sleep 1000
done
