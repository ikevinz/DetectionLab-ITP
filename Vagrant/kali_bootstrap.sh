#! /usr/bin/env bash

# This is the script that is used to provision the kali host

install_filebeats() {
    # Install Filebeats
    echo "[$(date +%H:%M:%S)]: Installing Filebeats..."
}

postinstall_tasks() {
    # Configure rsyslog
    echo "[$(date +%H:%M:%S)]: Configuring rsyslog for shell command collection..."

    # Configure zsh
    echo "[$(date +%H:%M:%S)]: Configuring ZSH..."

    # Configure ELK Forwarding
    echo "[$(date +%H:%M:%S)]: Configuring ELK & FileBeats forwarding..."
}

main() {
    postinstall_tasks
}

main
exit 0