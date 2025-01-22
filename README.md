# SSH Honeypot with Alpine Linux and Ubuntu-Like Environment

This project creates a Dockerized SSH honeypot designed to resemble a typical Ubuntu server environment. The honeypot logs all connection attempts and user commands for analysis, making it an effective tool for gathering intelligence about potential attackers.

---

## Features

- **Ubuntu-Like Terminal:** Simulates an Ubuntu 20.04 server using Zsh.
- **Command Logging:** Logs all user activity and commands to `/var/log/honeypot`.
- **Custom Fake Commands:** Mimics outputs for common commands like `ls`, `uname`, and `df`.
- **Public Key Authentication:** Allows attackers to log in using provided public keys.
- **Dockerized Deployment:** Easy to deploy and isolated from the host system.

---

## Directory Structure

```plaintext
.
├── Dockerfile               # Docker configuration for building the honeypot image
├── docker-compose.yml       # Docker Compose file for container management
├── sshd_config              # Custom SSH server configuration
├── fake-shell.sh            # Script for a fake shell environment
├── fake-zshrc               # Fake Zsh configuration for realism
├── authorized_keys          # Public keys for SSH authentication
├── honeypot.log             # Log file for recording activity
└── README.md                # Documentation
```

---

## Prerequisites

1. **Docker:** Install Docker. [Get Docker](https://docs.docker.com/get-docker/)
2. **Docker Compose:** Install Docker Compose. [Get Docker Compose](https://docs.docker.com/compose/install/)

---

## Setup Instructions

### 1. Clone the Repository

```bash
git https://github.com/RahalAmrith/ssh_honeypot.git
cd ssh-honeypot
```

### 2. Configure Public Keys

Add the public keys for authentication to the `authorized_keys` file:

```plaintext
ssh-rsa AAAAB3... your-key-comment
```

### 3. Build the Docker Image

```bash
docker-compose build
```

### 4. Start the Honeypot

```bash
docker-compose up -d
```

### 5. Monitor Activity

View live logs of user activity:

```bash
tail -f honeypot.log
```

### 6. Stop the Honeypot

To stop and remove the container:

```bash
docker-compose down
```

---

## Configuration Details

### SSH Configuration (`sshd_config`)

- **Port:** 22 (mapped to 2222 on the host)
- **Authentication:**
  - Password Authentication: Disabled
  - Public Key Authentication: Enabled
- **Force Command:** A fake shell (`/usr/local/bin/fake-shell`) is executed after login.

### Fake Shell (`fake-shell.sh`)

- Logs all commands entered by the user.
- Mimics common Linux commands such as:
  - `ls`
  - `uname`
  - `df`
  - `whoami`
- Displays a realistic-looking prompt: `fake-server@hostname:~$`.

### Fake Zsh Configuration (`fake-zshrc`)

- Simulates an Ubuntu-like Zsh shell with a similar prompt style.
- Displays a fake Message of the Day (MOTD) on login.
- Outputs a fake "last login" message with the attacker's IP.

### Docker Compose Configuration (`docker-compose.yml`)

- Maps:
  - Port `2222` (host) → Port `22` (container)
  - `authorized_keys` file for SSH access
  - `honeypot.log` for persistent logging
- Configured for automatic restarts on failure.

---

## Example Interaction

After logging in, attackers will experience the following:

```plaintext


   ⠀⠀⠀⣿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⢀⣿⣿⣿⣿⣿⣿⣆⡀⠀⠀⠀⠀⣠⣴⣦⡄⢤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣷⣷⣶⣶⣿⣿⣿⣿⡀⣽⡿⣶⣦⡀⠀⠀⠀⠀⠀
   ⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡿⣿⣿⣿⣿⣆⠀⠀⠀⠀
   ⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣦⠀⠀⠀
   ⠀⠀⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣟⣿⣿⣿⣿⣿⡿⢟⣿⣷⡀⠀
   ⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣭⣿⣿⣽⣿⣽⣾⣿⣿⣿⠛⠉⠉⠀⢈⣿⣿⡇⠀
   ⠀⠀⠀⢻⣿⣿⠛⠉⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠡⠤⠄⠁⠀⠀⢻⣿⡇⠀
   ⠀⠀⠀⠘⣿⣿⠄⠀⠀⠀⠀⠀⣉⠙⠋⢿⣿⣯⠀⠀⠀⠀⠀⠀⣰⣿⣿⡿⡃⠀
   ⠀⠀⠀⠀⢹⣿⣇⣀⠀⠈⠉⠉⠁⠀⣤⢠⣿⣿⣧⡆⣤⣤⡀⣾⣿⣿⣿⢠⡇⠀
   ⠀⠀⠀⠀⠀⣿⣿⣿⣷⣤⠄⣀⣴⣧⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⠇⠀
   ⠀⠀⠀⠀⠀⠸⣿⣯⠉⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⡯⠁⡌⠀⠀
   ⠀⠀⠀⠀⠀⠀⠙⢿⡄⢿⣿⣿⣿⣿⣿⣎⠙⠻⠛⣁⣼⣿⣿⡿⠛⠁⡸⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠈⢿⡄⠉⣿⡿⣿⣿⣿⣿⣷⣬⣿⡿⠟⠋⢀⣴⡞⠁⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⠀⠀⠀⠀⠉⠉⠋⠉⠉⠁⠀⢀⣴⣿⡿⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⠿⢃⣴⣿⣿⣿⠃⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀

#################################################
#  HAHAHA! Welcome to Gotham's darkest server.  #
#  If you're here without permission,           #
#  you'd better be the Batman... or else!       #
#  Proceed with caution, clown.                 #
#################################################


Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-60-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

Last login: Wed, 22 Jan 2025 18:01:23 +0000 from 192.168.0.75

opc@MS_Automation:~$
```

---

## Security Considerations

- **Isolation:** The honeypot is sandboxed in a Docker container.
- **No Real Access:** The `ForceCommand` restricts users to the fake shell.
- **Logging:** All actions are logged to help understand attacker behavior.

---

## Troubleshooting

### Container Not Starting

Check logs for errors:

```bash
docker logs ssh-honeypot
```

### Logs Not Captured

Ensure the `honeypot.log` file exists and is writable:

```bash
touch honeypot.log
chmod 666 honeypot.log
```

---

## Enhancements

1. **Simulate More Commands:** Add commands like `ping`, `top`, or `cat` for realism.
2. **Alerting:** Implement real-time alerts for connection attempts.
3. **Expand Fake Filesystem:** Add fake data or directories to engage attackers further.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Contributions

Contributions are welcome! Fork the repository, make your changes, and submit a pull request.

---

## Author

**Your Name**  
Senior Cloud Engineer and Fullstack Developer  
Email: rahalamrith46@gmail.com
```
