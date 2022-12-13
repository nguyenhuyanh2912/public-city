#!/bin/bash
#Installing Kubeadm Kubectl Kubelet

#Update and Install requirement package
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

#Check if keyrings exits
if [[ -d /etc/apt/keyrings ]]; then
  echo "Keyrings FOLDER EXIST"
else
  mkdir /etc/apt/keyrings
fi
#download the google cloud public signing key
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

#Add the K8S apt repository
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

#update pakage
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl



#Set Cgroup drivers as systemd
cat > /etc/containerd/config.toml << EOF
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    SystemdCgroup = true
EOF