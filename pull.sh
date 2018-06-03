#!/bin/bash

images=(kube-proxy-amd64:v1.10.0
		kube-scheduler-amd64:v1.10.0
		kube-controller-manager-amd64:v1.10.0
		kube-apiserver-amd64:v1.10.0
		etcd-amd64:3.1.12
		pause-amd64:3.1
		kubernetes-dashboard-amd64:v1.8.3
		k8s-dns-sidecar-amd64:1.14.7
		k8s-dns-kube-dns-amd64:1.14.7
		k8s-dns-dnsmasq-nanny-amd64:1.14.7
)

for image in ${images[@]};do
    echo $image
	docker pull quxf2012/$image
	docker tag quxf2012/$image gcr.io/google_containers/$image && docker rmi quxf2012/$image
done
