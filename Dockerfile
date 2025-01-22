FROM alpine:latest

RUN apk add --no-cache \
    openssh-server \
    bash \
    tcpdump \
    openssh-server-pam \
    libqrencode \
    zsh

RUN adduser -D -h /home/opc opc
RUN echo "opc:Codegen@321" | chpasswd
RUN mkdir -p /home/opc/.ssh
RUN chown opc:opc /home/opc/.ssh
RUN chmod 700 /home/opc/.ssh
COPY ./authorized_keys /home/opc/.ssh/authorized_keys
RUN chown opc:opc /home/opc/.ssh/authorized_keys
RUN chmod 600 /home/opc/.ssh/authorized_keys


# Copy the custom logging script
COPY connection_logger.sh /usr/local/bin/honeypot-logger
RUN chmod +x /usr/local/bin/honeypot-logger

# Copy SSH config file
COPY sshd_config /etc/ssh/sshd_config

# config banners
COPY banner /etc/motd
RUN mkdir -p /etc/ssh
COPY banner /etc/ssh/banner

# config terminal
COPY zshrc /home/opc/.zshrc
RUN chown opc:opc /home/opc/.zshrc


# Ensure SSH host keys are generated
RUN mkdir -p /var/run/sshd && ssh-keygen -A

# change hostname
RUN echo "MS_Automation" > /etc/hostname

# Expose SSH port
EXPOSE 22


CMD ["/usr/sbin/sshd", "-D"]