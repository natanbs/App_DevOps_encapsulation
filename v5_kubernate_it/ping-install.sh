#!/bin/bash
kubectl create -f namespace.yml
kubectl create -f redis-confmap.yml
kubectl create -f svc-redis.yml
kubectl create -f svc-flask.yml
kubectl create -f deploy-redis.yml
kubectl create -f deploy-flask.yml
echo
echo
kubectl get all -n ping-ns -o wide
