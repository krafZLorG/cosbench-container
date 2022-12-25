#!/bin/bash

if [[ -z "$1" ]]; then
    update-ca-trust
    sh start-all.sh
elif [[ "$1" = "controller" ]]; then
    sh start-controller.sh
elif [[ "$1" = "driver" ]]; then
    update-ca-trust
    sh start-driver.sh
else
    exit 1;
fi

while true; do sleep 1000; done

