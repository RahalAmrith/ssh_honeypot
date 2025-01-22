#!/bin/bash

# Log details of the connection
echo "$(date '+%Y-%m-%d %H:%M:%S') - Connection attempt" >> /var/log/honeypot
echo "  Remote IP: ${SSH_CLIENT%% *}" >> /var/log/honeypot
echo "  Username: $(whoami)" >> /var/log/honeypot
echo "  Command: $command" >> /var/log/honeypot
echo "---" >> /var/log/honeypot

# Prevent actual command execution
exec /bin/zsh