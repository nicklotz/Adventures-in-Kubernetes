#/bin/bash

gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="sudo zypper ar http://download.opensuse.org/tumbleweed/repo/oss/ Tumbleweed" &> /dev/null

gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="sudo zypper --gpg-auto-import-keys ref; sudo zypper in -y -t pattern kvm_server kvm_tools" &> /dev/null

gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="sudo systemctl start libvirtd; sudo systemctl enable libvirtd" &> /dev/null


gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="sudo virsh net-list --all" &> /dev/null


gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --command="sudo virsh net-start default; sudo virsh net-autostart default"

gcloud compute ssh kubernetes-host --zone=us-east1-b --command="sudo zypper in -y tftpboot-installation-openSUSE-MicroOS-x86_64"
