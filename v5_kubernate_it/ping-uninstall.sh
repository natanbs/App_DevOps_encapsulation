#!/bin/bash

kubectl delete deploy flask-deploy
kubectl delete deploy redis-deploy
kubectl delete svc flask-svc
kubectl delete svc redis-svc

echo
echo
kubectl get all -o wide
