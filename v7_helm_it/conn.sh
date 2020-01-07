#!/bin/bash
pass=`helm get manifest redis -n ping-ns | grep redis-password: | awk '{print $2}'` 
sed -i "" "s/^  redis-pass.*/  redis-pass: ${pass}/g" ./flask-ping/templates/redis-confmap.yaml
