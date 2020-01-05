#!/bin/bash

kubectl delete svc flask-svc -n ping-ns
kubectl delete svc redis-svc -n ping-ns
kubectl delete deploy flask-ping -n ping-ns
kubectl delete deploy redis-ping -n ping-ns
kubectl delete pvc redis-pvc ping-ns
kubectl delete pv redis-pv
kubectl delete ns ping-ns

echo
echo
kubectl get all -n ping-ns -o wide
