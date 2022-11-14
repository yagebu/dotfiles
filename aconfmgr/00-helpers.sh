#!/bin/bash

if [[ "$HOSTNAME" == "js-arch" ]]; then
    machine_type="desktop"
elif [[ "$HOSTNAME" == "js-mob" ]]; then
    machine_type="desktop"
elif [[ "$HOSTNAME" == "js-zen" ]]; then
    machine_type="desktop"
elif [[ "$HOSTNAME" == "js-atom" ]]; then
    machine_type="server"
fi

function get_machine_type() {
    echo "$machine_type"
}

echo "Running aconfmgr on host '$HOSTNAME' - machine type '$machine_type'"
