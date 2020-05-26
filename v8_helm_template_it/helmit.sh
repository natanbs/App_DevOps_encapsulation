#!/bin/bash
helm un flask-ping redis -n ping-ns
kubectl apply -f namespace.yml
helm install -f redis-config.yaml redis stable/redis -n ping-ns
./conn.sh
helm install flask-ping ./flask-ping -n ping-ns
