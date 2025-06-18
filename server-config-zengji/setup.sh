#!/usr/bin/env bash

echo "⚠️  WARNING ⚠️"
echo "This script is designed to be run ONCE on a new cloud instance."
echo "Running it multiple times may cause issues with your package sources."
echo "This script will:"
echo "  - Modify your apt sources to use a custom mirror"
echo "  - Install Python pip and uv package manager"
echo "  - Install various system utilities"
echo ""

# Confirmation prompt
read -p "Do you want to proceed with the setup? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Setup cancelled."
    exit 1
fi

# Check if backup already exists (indication script was run before)
if [ -f /etc/apt/sources.list.bak ]; then
    echo "Warning: /etc/apt/sources.list.bak already exists."
    echo "This suggests the script may have been run before."
    read -p "Continue anyway? (y/n): " override
    if [[ "$override" != "y" && "$override" != "Y" ]]; then
        echo "Setup cancelled."
        exit 1
    fi
fi

# Proceed with the setup
echo "Starting setup..."

cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "Original sources list backed up to /etc/apt/sources.list.bak"

sed -i 's|http://[^ ]*.ubuntu.com/ubuntu/|http://nexus.sii.shaipower.online/repository/ubuntu/|g' /etc/apt/sources.list
echo "APT sources updated to use custom mirror"

echo "Updating package lists..."
apt update

echo "Installing python3-pip..."
apt install -y python3-pip

echo "Installing uv package manager..."
pip install uv -i http://nexus.sii.shaipower.online/repository/pypi/simple --trusted-host nexus.sii.shaipower.online

echo "Installing system utilities..."
apt install -y vim iproute2 tmux autojump aria2 curl wget htop btop zsh git nvtop

echo "Installing gitstatusd for p10k..."
mkdir -p ~/.cache/gitstatus
cp /inspire/hdd/ws-c6f77a66-a5f5-45dc-a4ce-1e856fe7a7b4/project/xiashijie-240108120112/server-config/gitstatusd-linux-x86_64 ~/.cache/gitstatus

echo "✅ Setup completed successfully!"