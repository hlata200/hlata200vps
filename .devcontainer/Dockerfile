# Start with a standard Codespaces Ubuntu image
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Switch to root user to install software
USER root

# This prevents installers from asking interactive questions
ENV DEBIAN_FRONTEND=noninteractive

# Update software lists and install our required packages
RUN apt-get update && \
    apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    qrencode \
    && rm -rf /var/lib/apt/lists/*

# Install Tailscale
RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.no-sync.gpg | gpg --dearmor -o /usr/share/keyrings/tailscale-archive-keyring.gpg && \
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list && \
    apt-get update && \
    apt-get install -y tailscale

# Switch back to the standard, non-root 'codespace' user
USER codespace
