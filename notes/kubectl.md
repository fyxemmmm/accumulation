```shell script
kubectl config view --minify=true --raw

kubectl create secret generic production-tls \
    --save-config --dry-run=client \
    --from-file=./tls.key --from-file=./tls.crt \
    -o yaml | kubectl apply -f -
```
