## install k8s
安装docker 略

开始安装



```shell
sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

sudo yum makecache
sudo yum -y install kubelet-1.20.2  kubeadm-1.20.2  kubectl-1.20.2
sudo systemctl enable kubelet
```


#### 使用systemd作为docker的cgroup driver
```shell
sudo vi  /etc/docker/daemon.json   （没有则创建）
加入
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}

systemctl daemon-reload  && systemctl restart docker

```

#### 切换到root
```shell
# （如果是重置机器，需要执行）
kubeadm reset
rm /etc/cni/net.d -fr
iptables -F 
yum -y remove kubelet-1.18.6  kubeadm-1.18.6  kubectl-1.18.6
# （重置end）

yum -y install kubelet-1.20.2  kubeadm-1.20.2  kubectl-1.20.2

echo 1 > /proc/sys/net/ipv4/ip_forward
modprobe br_netfilter
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

systemctl daemon-reload  # 可能会报错 可以不执行这个
systemctl enable kubelet
```

#### 主机执行
```shell
#主机执行：
kubeadm init --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers  --kubernetes-version=1.20.2 --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12  

#得到这个结果，给另外worker去执行
kubeadm join 192.168.0.191:6443 --token zx5rj1.19yqkv7q2uehatit \
    --discovery-token-ca-cert-hash sha256:b5a066c56e73896dc14530d5464eadd45732de6bd3806e878c80ed589e4ea502
```

```shell
#然后退出到普通用户, 用kubectl命令执行
#去除主节点污点
kubectl taint nodes --all node-role.kubernetes.io/master-   # (后面一个 – 是需要的)

给工作节点打标签
kubectl label node huawei-worker  node-role.kubernetes.io/node=node

```

```shell
#让外网可以访问
#删除 apiserver的证书和key
#主节点上
cd /etc/kubernetes/pki && rm -f apiserver.key && rm -f  apiserver.crt
sudo kubeadm init phase certs apiserver   --apiserver-cert-extra-sans 121.36.226.197
kubeadm alpha certs renew apiserver
```

#### 安装flannel
```shell
https://github.com/flannel-io/flannel
For Kubernetes v1.17+ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# apply里面的镜像要替换下，可以用katacoda
```