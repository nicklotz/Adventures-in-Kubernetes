#/bin/bash

echo "Configuring nested virtualization on ephemeral boot disk"
gcloud compute disks create suse-virt-disk \
  --image-project suse-cloud \
  --image-family sles-15 \
  --zone us-east1-b > /dev/null 2> /dev/null
  
echo "Creating peristent nested VM image"
gcloud compute images create suse-virt-image \
  --source-disk suse-virt-disk \
  --source-disk-zone us-east1-b \
  --licenses "https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx" > /dev/null 2> /dev/null
  
echo "Cleaning up ephemeral disks"
gcloud compute disks delete suse-virt-disk \
  --zone=us-east1-b \
  --quiet > /dev/null 2> /dev/null
  
echo "Launching virtualization host"
gcloud compute instances create kubernetes-host \
  --zone us-east1-b \
  --min-cpu-platform "Intel Haswell" \
  --image suse-virt-image \
  --boot-disk-size=500GB \
  --custom-cpu=20 \
  --custom-memory=75GB > /dev/null 2> /dev/null
  
echo "Configuring SSH on host"
gcloud compute ssh kubernetes-host \
  --zone=us-east1-b \
  --force-key-file-overwrite \
  --quiet > /dev/null 2> /dev/null

sleep 45s

echo "Installing KVM virtual environment"
bash kvm-install.sh &> /dev/null

echo "Setting up kubic autoinstallation"
bash deploy-kubic.sh
