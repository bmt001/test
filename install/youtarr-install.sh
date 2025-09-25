#!/usr/bin/env bash  
  
# Copyright (c) 2021-2025 community-scripts ORG  
# Author: [your-name]  
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE  
# Source: https://github.com/DialmasterOrg/Youtarr  
  
source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"  
color  
verb_ip6  
catch_errors  
setting_up_container  
network_check  
update_os  
  
msg_info "Installing Dependencies"  
$STD apt-get install -y \  
  curl \  
  sudo \  
  mc \  
  git \  
  ca-certificates \  
  gnupg \  
  python3 \  
  python3-pip \  
  ffmpeg  
msg_ok "Installed Dependencies"  
  
msg_info "Setting up Node.js Repository"  
mkdir -p /etc/apt/keyrings  
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg  
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" >/etc/apt/sources.list.d/nodesource.list  
msg_ok "Set up Node.js Repository"  
  
msg_info "Installing Node.js/npm"  
$STD apt-get update  
$STD apt-get install -y nodejs  
$STD npm install -g npm@latest  
msg_ok "Installed Node.js/npm"  
  
msg_info "Installing yt-dlp"  
$STD pip3 install yt-dlp  
msg_ok "Installed yt-dlp"  
  
msg_info "Installing Youtarr (Patience)"  
$STD git clone https://github.com/DialmasterOrg/Youtarr.git /opt/youtarr  
cd /opt/youtarr  
$STD npm install  
msg_ok "Installed Youtarr"  
  
msg_info "Creating Service"  
cat <<EOF >/etc/systemd/system/youtarr.service  
[Unit]  
Description=Youtarr Service  
After=network.target  
  
[Service]  
Type=simple  
User=root  
WorkingDirectory=/opt/youtarr  
ExecStart=/usr/bin/node server.js  
Restart=always  
RestartSec=10  
  
[Install]  
WantedBy=multi-user.target  
EOF  
systemctl enable -q --now youtarr.service  
msg_ok "Created Service"  
  
motd_ssh  
customize  
  
msg_info "Cleaning up"  
$STD apt-get -y autoremove  
$STD apt-get -y autoclean  
msg_ok "Cleaned"
