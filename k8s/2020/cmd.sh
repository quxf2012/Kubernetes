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


#Job & CronJob
kubectl get cronjob --watch
kubectl delete cronjob pi
kubectl get job --watch



#
kubectl run nginx --image nginx   #废弃
#创建一个deployment 运行nginx
kubectl create deployment nginx --image nginx

#比较当前配置与系统中的差异
kubectl diff -f deployment-20200119.yml

kubectl diff -R -f configs/
kubectl apply -R -f configs/

kubectl get namespace
kubectl create namespace  namespace-1
#删除命名空间,并删除该命名空间中的所有东西
kubectl delete namespaces namespace-1
#配置查看
kubectl config view
kubect config set-context --current --namespace=default

kubectl api-resources --namespaced=true
kubectl api-resources --namespaced=false

#标签选择器
#in notin exists
kubectl get pods -l app=nginx,tier=frontend
kubectl get pods -l 'environment in (dev,qa),tier in (frontend)'

#字段选择器
#https://kubernetes.io/zh/docs/concepts/overview/working-with-objects/field-selectors/
kubectl get pods --field-selector status.phase=Running
kubectl get ingress --field-selector 


kubectl get statefulsets,services --all-naespaces --field-selector metadata.namespace!=default

kubectl get node
kubectl describe node name


#更新标签 
#更新所有app=nginx的pods tier为fe
kubectl label pods -l app=nginx tier=fe
# -l 根据label过滤, -L 显示tier的值
kubectl get pods -l app=nginx -L tier

#更新注解
kubectl annotate pods my-nginx description="my frontend running nginx"

#扩缩应用
kubectl scale deployment/my-nginx --replicas=1
#自动扩容和收缩,autoscale 和 scale 冲突的,autoscale优先级更高
kubectl autoscale deployment/my-nginx --min=1 --max=3

#HorizontalPodAutoscaler
#查看autoscale创建的自动扩展
kubectl get hpa
#删除 autoscale 创建的nginx自动扩展
kubectl delete hpa nginx
#修改autoscale
kubectl edit hpa nginx

