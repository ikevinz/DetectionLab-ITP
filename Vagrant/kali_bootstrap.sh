#! /usr/bin/env bash

# This is the script that is used to provision the kali host

install_filebeats() {
    # Install Filebeats
    echo "[$(date +%H:%M:%S)]: Installing Filebeats..."
    mkdir /tmp/setup_temp
    cd /tmp/setup_temp
    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.13.0-amd64.deb
    sudo dpkg -i filebeat-7.13.0-amd64.deb
    echo "[$(date +%H:%M:%S)]: Filebeats Installed!"
}

configure_rsyslog() {
    # Configure rsyslog
    echo "[$(date +%H:%M:%S)]: Configuring rsyslog for shell command collection..."
}

configure_zsh() {
    # Configure zsh
    echo "[$(date +%H:%M:%S)]: Configuring ZSH..."
}

configure_filebeat() {
    # Configure ELK Forwarding
    echo "[$(date +%H:%M:%S)]: Configuring ELK & FileBeats forwarding..."
}

cleanup(){
    #Deleting temp files
    rm -rf /tmp/setup_temp
}

main() {
    #Installing 
    echo "[$(date +%H:%M:%S)]: Setting Up RED Machine..."
    install_filebeats
    echo "[$(date +%H:%M:%S)]: Installation Complete."

    #Configuring
    echo "[$(date +%H:%M:%S)]: Configuring RED Machine..."
    configure_rsyslog
    configure_zsh
    configure_filebeat
    echo "[$(date +%H:%M:%S)]: Configuration complete."

    #Cleanup
    echo "[$(date +%H:%M:%S)]: Cleaning Up..."
    cleanup
    echo "[$(date +%H:%M:%S)]: Clean up complete."
}

main
exit 0