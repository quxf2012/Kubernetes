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
