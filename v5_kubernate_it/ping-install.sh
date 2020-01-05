#!/bin/bash
kubectl create -f svc-redis.yml
kubectl create -f svc-flask.yml
kubectl create -f deploy-redis.yml
kubectl create -f deploy-flask.yml
echo
echo
kubectl get all -o wide
