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
  
gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="cd /srv/tftpboot/; sudo cp -av /usr/share/tftpboot-installation/openSUSE-MicroOS-x86_64/boot/x86_64/root ."
  
gcloud compute scp pxelinux.cfg.default kubernetes-host:~/pxelinux.cfg.default --zone=us-east1-b

gcloud compute ssh kubernetes-host --zone=us-east1-b --command="sudo mv ~/pxelinux.cfg.default /srv/tftpboot/pxelinux.cfg/default"
