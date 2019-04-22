#/bin/bash

gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="sudo systemctl enable --now tftp.socket; sudo systemctl start tftp.socket"

gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="sudo systemctl status tftp.socket"

gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="cd /srv/tftpboot/; sudo cp -av /usr/share/tftpboot-installation/openSUSE-MicroOS-x86_64/net/{message,pxelinux.*} ."
