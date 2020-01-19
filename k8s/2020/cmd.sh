kubectl apply -f rs-20200119.yml 
#可以修改rs的信息, 副本数量等
kubectl edit -f rs-20200119.yml 
kubectl delete -f rs-20200119.yml 
kubectl delete rs example
#导出 rs  信息
kubectl get rs frontend -o yaml
kubectl describe rs nginx-deployment-5c559d5697
#导出 pod信息
kubectl get pod frontend-s62jh -o yaml

kubectl get pods --watch

kubectl apply -f deployment-20200119.yml 

# --record 参数 可以在annotation中记录 命令
kubectl create -f https://kubernetes.io/docs/user-guide/nginx-deployment.yaml --record
kubectl apply --filename=/data/scripts/app/fbgweb.yaml --record=true

#回滚到上一个版本
kubectl rollout undo deployment.v1.apps/nginx-deployment
kubectl rollout undo deploy/nginx-deployment

kubectl rollout history deployment/nginx-deployment 检查deployment升级的历史记录
kubectl rollout history deployment/nginx-deployment --revision=2 查看单个revision 的详细信息
kubectl rollout undo deployment/nginx-deployment 回退到上一个版本 
kubectl rollout undo deployment/nginx-deployment --to-revision=2 根据--revision参数指定某个历史版本

kubectl rollout status deployment/nginx-deployment  
kubectl rollout status deployment/nginx-deployment  --watch=false

kubectl rollout pause deployment nginx-deployment
kubectl rollout pause deployment.v1.apps/nginx-deployment
kubectl rollout resume deployment nginx-deployment    


#删除
kubectl delete deployments.apps nginx-deployment
kubectl delete apply -f deployment-20200119.yml
kubectl delete deployment/nginx-deployment



#satefulSet
kubectl get statefulset.apps
kubectl get statefulset
