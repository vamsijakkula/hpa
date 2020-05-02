Kubernetes
**********
minikube addons list 
minikube addons enable metrics-server

Commands to check the node and pod metrics
********************************************
kubectl top node

kubectl top pod

kubectl describe hpa

HPA Settings 
*************

minikube start --extra-config=controller-manager.horizontal-pod-autoscaler-upscale-delay=1m --extra-config=controller-manager.horizontal-pod-autoscaler-downscale-delay=1m --extra-config=controller-manager.horizontal-pod-autoscaler-sync-period=10s --extra-config=controller-manager.horizontal-pod-autoscaler-downscale-stabilization=1m

HPA 
*****
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10

Load generator
**************
kubectl run --generator=run-pod/v1 -it --rm load-generator --image=busybox /bin/sh
while true; do wget -q -O- http://php-apache; done

kubectl get --raw /apis/metrics.k8s.io/v1beta1


kubectl get pods -n kube-system | grep metrics-server

kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | jq '.'

kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods | jq '.'

kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes \
| jq '[.items [] | {nodeName: .metadata.name, nodeCpu: .usage.cpu, nodeMemory: .usage.memory}]'