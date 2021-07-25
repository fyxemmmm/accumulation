#### git clone https://github.com/coreos/kube-prometheus.git
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
