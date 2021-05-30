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
    
    # Creating rsyslog conf file
    cd /etc/rsyslog.d
    echo "local6.*  /var/log/zsh.log" >> zsh.conf

    # Create the file under /var/log
    sudo touch /var/log/zsh.log

    echo "[$(date +%H:%M:%S)]: Rsyslog configuration complete."
}

configure_zsh() {
    # Configure zsh
    echo "[$(date +%H:%M:%S)]: Configuring ZSH..."

    cd /home/kali
    sed '/^setopt hist_verify/a # ZSH Config for Filebeats/ELK\nsetopt INC_APPEND_HISTORY' .zshrc > temp
    sed "/^precmd() {/a     # Logging zsh commands to rsyslog\n    eval 'RETRN_VAL=\$?;logger -S 10000 -p local6.debug \"{\"user\": \"\$(whoami)\", \"path\": \"\$(pwd)\", \"pid\": \"\$\$\", \"b64_command\": \"\$(history | tail -n1 | /usr/bin/sed \"s/[ 0-9 ]*//\" | base64 -w0 )\", \"status\": \"\$RETRN_VAL\"}\"'" temp > temp2
    mv temp2 .zshrc
    rm temp
    source ~/.zshrc

    echo "[$(date +%H:%M:%S)]: ZSH configuration complete."
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
    #configure_filebeat
    echo "[$(date +%H:%M:%S)]: Configuration complete."

    #Cleanup
    echo "[$(date +%H:%M:%S)]: Cleaning Up..."
    #cleanup
    echo "[$(date +%H:%M:%S)]: Clean up complete."
}

main
exit 0