kubectl create -f mysql-rc.yml 
kubectl create -f mysql-svc.yml
kubectl get pods
kubectl get rc
kubectl  get service

kubectl create -f myweb-svc.yml 

kubectl describe node nodename

kubectl describe pod
kubectl describe rc
kubectl --namespace=kube-system describe pod [podname]


kubectl create -f mysql-pod.yml 
kubectl delete -f mysql-pod.yml 



kubectl  create -f mysql-deployment.yml 
kubectl describe deployments

kubectl scale rc mysql --replicas=3
#名称为fronted 的deployment cpu使用率大于90时自动扩展,或者收缩
kubectl autoscale deployment frontend --cpu-percent=90 --min=1 --max=10

kubectl get namespaces  #ns

#持久化卷
kubectl get pv
#pod 通过pvc使用pv
kubectl get pvc


#获取某个资源输出为yaml格式
kubectl get pods  --namespace=development alpine  -o yaml

#进入pods的容器中
kubectl exec -it myweb-h4hd4 -c myweb sh

#编辑名称myweb的rc
kubectl edit rc/myweb
kubect edit deployment/nginx-deployment
kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1
kubectl set image rc/myweb myweb=openresty/openresty:latest



deployment 控制rs

#滚动升级 deployment
kubectl create -f myweb-deployment.yml  #创建deploy
#动态升级NGINX
    kubectl set image deployment/nginx-deployment nginx=nginx:alpine  #修改nginx的image
    kubectl edit deployment/nginx-deployment  #修改nginx的镜像地址后保存
    kubectl describe deployment/nginx-deploymeng   #查看升级动态
    

kubectl get pods   #查看
kubectl get deployment  #查看状态
kubectl describe deploy/myweb   #查看更新过程
kubectl get rs  #查看rs,更新完成旧的rs数量为0



#查看pods日志
kubectl  logs -f pod
docker logs -f a9e
