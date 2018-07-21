#!/bin/bash

images=(kube-proxy-amd64:v1.11.1
    kube-scheduler-amd64:v1.11.1
    kube-controller-manager-amd64:v1.11.1
    kube-apiserver-amd64:v1.11.1
    etcd-amd64:3.1.12
    pause-amd64:3.1
    kubernetes-dashboard-amd64:v1.8.3
    k8s-dns-sidecar-amd64:1.14.8
    k8s-dns-kube-dns-amd64:1.14.8
    k8s-dns-dnsmasq-nanny-amd64:1.14.8
)

for image in ${images[@]};do
    echo $image
    docker pull quxf2012/$image
    #docker tag quxf2012/$image gcr.io/google_containers/$image 
    #k8s.gcr.io in use,创建标签成功后删除,临时标签
    docker tag quxf2012/$image k8s.gcr.io/$image && docker rmi quxf2012/$image
done


#down quay.io/coreos/flannel:v0.10.0-amd64

docker pull quxf2012/kube-flannel:v0.10.0-amd64
docker tag quxf2012/kube-flannel:v0.10.0-amd64 quay.io/coreos/flannel:v0.10.0-amd64 && docker rmi quxf2012/kube-flannel:v0.10.0-amd64
