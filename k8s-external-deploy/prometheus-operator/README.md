#### git clone https://github.com/coreos/kube-prometheus.git || https://github.com/fyxemmmm/kube-prometheus.git
#### cd manifests
#### kubectl apply -f setup/
#### kubectl apply -f .

---
#### # 将 type: ClusterIP 更改为 type: NodePort
kubectl edit svc grafana -n monitoring  
kubectl edit svc alertmanager-main -n monitoring
kubectl edit svc prometheus-k8s -n monitoring
kubectl get svc -n monitoring

注： grafana需要设置持久化， prometheus需要持久化 默认empty dir
#### alert manager副本数变成1, 和secret绑定的配置, 需要先delete删除之后再创建 即可动态挂载
#### 如果告警按照namespace分组，有default、kube-system 这2个组，报警信息会同时发出去，意思是有2条，同一个分组会有时间间隔，具体看配置即可