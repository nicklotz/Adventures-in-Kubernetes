#/bin/bash

gcloud compute ssh kubernetes-host --zone=us-east1-b --command="sudo zypper ref; sudo zypper in -y -t pattern kvm_server kvm_tools"
