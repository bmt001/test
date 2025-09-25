#!/usr/bin/env bash  
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)  
  
function header_info {  
clear  
cat <<"EOF"  
    __  __            __                  
   /  |/  /___  ____  / /_____ ________   
  / /|_/ / __ \/ __ \/ __/ __ `/ ___/ /  
 / /  / / /_/ / / / / /_/ /_/ / /  / /   
/_/  /_/\____/_/ /_/\__/\__,_/_/  /_/    
                                        
EOF
}  
  
header_info  
echo -e "Loading..."  
APP="Youtarr"  
var_disk="8"  
var_cpu="2"  
var_ram="2048"  
var_os="debian"  
var_version="12"  
variables  
color  
catch_errors  
  
function default_settings() {  
  CT_TYPE="1"  
  PW=""  
  CT_ID=$NEXTID  
  HN=$NSAPP  
  DISK_SIZE="$var_disk"  
  CORE_COUNT="$var_cpu"  
  RAM_SIZE="$var_ram"  
  BRG="vmbr0"  
  NET="dhcp"  
  GATE=""  
  APT_CACHER=""  
  APT_CACHER_IP=""  
  DISABLEIP6="no"  
  MTU=""  
  SD=""  
  NS=""  
  MAC=""  
  VLAN=""  
  SSH="no"  
  VERB="no"  
  echo_default  
}  
  
start  
build_container  
description  
  
msg_ok "Completed Successfully!\n"  
echo -e "${APP} should be reachable by going to the following URL.  
         ${BL}http://${IP}:3000${CL} \n"
