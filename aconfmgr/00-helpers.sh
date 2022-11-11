#!/bin/bash

build_size="full"
if [[ "$HOSTNAME" == "js-arch" ]]; then
    machine_type="desktop"
elif [[ "$HOSTNAME" == "js-mob" ]]; then
    machine_type="desktop"
    build_size="minimal"
elif [[ "$HOSTNAME" == "js-zen" ]]; then
    machine_type="desktop"
    build_size="minimal"
elif [[ "$HOSTNAME" == "js-atom" ]]; then
    machine_type="server"
fi

function get_machine_type() {
    echo "$machine_type"
}


function get_build_size() {
    echo "$build_size"
}

echo "Running aconfmgr on host '$HOSTNAME' - machine type '$machine_type' - build_size: '$build_size'"
