#!/bin/bash

# Set a VNC password non-interactively.
# The password for your VNC connection will be "codespace".
mkdir -p ~/.vnc
echo "codespace" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Start the Tailscale daemon in the background
sudo tailscaled &

# Give the daemon a moment to start up
sleep 2

# Start the VNC Server using the password file we created
vncserver -geometry 1280x720 -rfbauth ~/.vnc/passwd :1 &

# Bring this machine online with Tailscale
sudo tailscale up

# --- Automation Script ---
echo "-----------------------------------------------------"
echo "          WAITING FOR TAILSCALE IP...                "
echo "-----------------------------------------------------"
while [ -z "$(tailscale ip -4 2>/dev/null)" ]; do sleep 1; done
IP_ADDRESS=$(tailscale ip -4)

echo ""
echo "-----------------------------------------------------"
echo "           READY TO CONNECT!"
echo ""
echo "    Your VNC Address is: $IP_ADDRESS:5901"
echo "    Your VNC Password is: codespace"
echo "    Or scan the QR code below with your phone's camera"
echo "-----------------------------------------------------"
echo ""

qrencode -t ANSIUTF8 "vnc://$IP_ADDRESS:5901"

echo ""
echo "-----------------------------------------------------"
echo "This terminal will keep running. You can now connect."
sleep infinity
