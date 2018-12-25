[kubeadm](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/)官方文档


# 配置软件源
  最好用centos7装,ubuntu容易出错
##  centos
```bash
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0

#docker
yum -y install yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```
## ubuntu
```bash
apt-get -y install apt-transport-httpsca-certificates curl software-properties-common

#kubernetes
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg |apt-key add -
cat<< EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF


#docker源,18.04暂时没源,直接执行下面命令添加16.04的源
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg |apt-key add -
add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
#ubuntu18.04暂时没有源,直接使用16.04的.
cat<< EOF > /etc/apt/sources.list.d/docker.list
deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial stable
EOF
```


# 安装docker和kubeadm

## centos
```bash
yum install kubelet kubeadm kubectl kubernetes-cni  #安装最新版
yum install kubeadm-1.10.0-0 kubectl-1.10.0-0 kubelet-1.10.0-0 kubernetes-cni #安装指定版
yum list docker-ce --showduplicates #查看源中的docker版本,k8s1.10.0支持17.03.2.ce
yum install docker-ce-17.03.2.ce
#上条命令装不上的,可以使用下面两条
rpm -i https://mirrors.aliyun.com/docker-ce/linux/centos/7/x86_64/stable/Packages/docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch.rpm

rpm -i https://mirrors.aliyun.com/docker-ce/linux/centos/7/x86_64/stable/Packages/docker-ce-17.03.2.ce-1.el7.centos.x86_64.rpm

```

## ubuntu

```bash
apt-get update

#安装kubeadm
apt-get install kubelet kubeadm kubectl kubernetes-cni

#安装指定版本docker
apt-cache madison docker-ce #查看版本库中的版本
apt-get install docker-ce=17.03.0~ce-0~ubuntu-xenial #安装指定版本的docker-ce

```




# 使用kubeadm安装kubernetes

## 准备工作
### 提前拉取kubeadm需要的docker镜像
```bash
git clone git@github.com:quxf2012/Kubernetes.git
cd Kubernetes
bash pull_1.11.1.sh
```

### 修改kubelet cgroup驱动和docker一致,没有则跳过
```bash
docker info|grep 'Cgroup Driver'
vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    --cgroup-driver=
```

### 调整系统参数
    grep '^net.bridge.bridge-nf-call-iptables' /etc/sysctl.conf || echo 'net.bridge.bridge-nf-call-iptables=1' >>/etc/sysctl.conf
    sysctl -p

## 使用kueadm安装并配置kubernetes

### 安装kubernetes,网段不要改
    kubeadm init --kubernetes-version=v1.11.1 --pod-network-cidr=10.244.0.0/16
![创建成功](https://raw.githubusercontent.com/quxf2012/Kubernetes/master/20180605105559.png)


### 配置访问k8s
#### root用户
    export KUBECONFIG=/etc/kubernetes/admin.conf
#### 非root用户
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

### 安装pod网络插件(Installing a pod network)
该插件需要kubeadm init 时指定 -pod-network-cidr=10.244.0.0/16
```bash
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```



### 查看集群创建状态
kubectl get pods --all-namespaces
![创建完成](https://raw.githubusercontent.com/quxf2012/Kubernetes/master/20180605105413.png)

### 调整master可以运行pods
    kubectl taint nodes --all node-role.kubernetes.io/master-

### 查看日志
    tail -f /var/log/syslog     #ubuntu
    tail -f /var/log/messages   #centos



## 安装 dashboard
    https://github.com/kubernetes/dashboard
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml






