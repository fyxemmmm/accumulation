先创建pvc和svc, 暴露出
- "--cluster-announce-ip"
- "121.36.xxxx"
- "--cluster-announce-port"
- "32xxx"
- "--cluster-announce-bus-port"
- "32xxx"

创建configmap

```
appendonly no
cluster-enabled yes
cluster-config-file /data/redis/nodes.conf
cluster-node-timeout 10000
dir /data/redis
port 6379
```

kubectl create configmap redis-cluster-conf --from-file=redis.conf



创建无头服务

```
apiVersion: v1
kind: Service
metadata:
  name: redis-cluster-service
  labels:
    app: redis
spec:
  ports:
    - name: redis-port
      port: 6379
  clusterIP: None
  selector:
    app: redis
    appCluster: redis-cluster
```



statefulset

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: redis-api-cluster
spec:
  serviceName: "redis-cluster-service"
  replicas: 6
  selector:
    matchLabels:
      app: redis
      appCluster: redis-cluster
  template:
    metadata:
      labels:
        app: redis
        appCluster: redis-cluster
    spec:
      containers:
        - name: redis
          image: "redis:5.0.12-alpine"
          command:
            - "redis-server"
          args:
            - "/data/redis/rediscfg/redis.conf"
            - "--protected-mode"
            - "no"
            - "--cluster-announce-ip"
            - "$(POD_IP)"
          ports:
            - name: redis
              containerPort: 6379
              protocol: "TCP"
            - name: cluster
              containerPort: 16379
              protocol: "TCP"
          volumeMounts:
            - name: "redis-conf"
              mountPath: "/data/redis/rediscfg"
            - name: "redis-data"
              mountPath: "/data/redis"
          env:
            - name: POD_IP
              valueFrom:
                fieldRef:
                  fieldPath: status.podIP
      volumes:
        - name: "redis-conf"
          configMap:
            name: "redis-cluster-conf"
            items:
              - key: "redis.conf"
                path: "redis.conf"
  volumeClaimTemplates:
    - apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: redis-data
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: 1Gi

```





redis-api-cluster-0                1/1     Running   0          5m13s   10.244.227.43    api-worker01   <none>           <none>
redis-api-cluster-1                1/1     Running   0          5m10s   10.244.237.157   woker53        <none>           <none>
redis-api-cluster-2                1/1     Running   0          5m5s    10.244.52.245    api-worker02   <none>           <none>
redis-api-cluster-3                1/1     Running   0          4m47s   10.244.253.211   api-worker03   <none>           <none>
redis-api-cluster-4                1/1     Running   0          4m40s   10.244.227.44    api-worker01   <none>           <none>
redis-api-cluster-5                1/1     Running   0          4m22s   10.244.237.158   woker53        <none>           <none>





redis-cli --cluster create redis-api-cluster-0.redis-cluster-service:6379  redis-api-cluster-1.redis-cluster-service:6379  redis-api-cluster-2.redis-cluster-service:6379





加入slave， 后者master

redis-cli --cluster add-node 172.17.0.13:6379 172.17.0.10:6379 --cluster-slave --cluster-master-id adf443a4d33c4db2c0d4669d61915ae6faa96b46