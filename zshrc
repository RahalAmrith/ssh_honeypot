# Fake Zsh configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Prompt to mimic Ubuntu's default Zsh
PROMPT='%F{cyan}%n@%m%f:%F{blue}%~%f$ '

# Display fake system information on login
echo -e "\nWelcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-60-generic x86_64)\n"

# Simulate motd
echo " * Documentation:  https://help.ubuntu.com"
echo " * Management:     https://landscape.canonical.com"
echo " * Support:        https://ubuntu.com/advantage"

echo -e "\nLast login: $(date -R) from ${SSH_CLIENT%% *}\n"
