# App_DevOps_encapsulation
## Helm the app 

Use Helm to build a templated app

Helm allows you to template you app, but first we will install Flask hard coded to get the hang of it:

To install Helm:
  Linux:   curl https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz | tar x && mv linux-amd64/helm /usr/local/bin/helm
  MacOS:   brew install helm
  Windows: choco install kubernetes-helm

Create the flask-ping deployment
```bash
	mkdir helm
        helm create flask-ping
        rm ingress.yaml serviceaccount.yaml  # Remove the currently confilictng manifests and which are not necessary at this stage.
```

Copy the existing deploy and service files to the templates directories:
```bash
        cd flask-ping/templates
        cp ../../../v6_pv_pvc_storage/deploy-flask.yml deployment.yaml
        cp ../../../v6_pv_pvc_storage/svc-flask.yml service.yaml
```

Copy the existing deploy and service files to the templates directories:
```bash
        cd redis-ping/templates
        cp -p ../../../deploy-redis.yml deployment.yaml
        cp -p ../../../svc-redis.yml service.yaml
        cp -p ../../../pv.yml .
        cp -p ../../../pvc.yml .
```

```bash
        cd ../..
        pwd          # App_DevOps_encapsulation/helm
        kcf namespace.yml
```

Install the apps:
```bash
        helm install flask-ping ./flask-ping -n ping-ns
        helm install redis-ping ./redis-ping -n ping-ns
```

You will not see the Redis files as they are cached.

You can override values with with your customized file. 
For example to disable the Redis cluster, you can create a redis-config.yaml file:
Install the apps:
```
cluster:
  enabled: false
```
The install:
```bash
        helm install redis-ping ./redis-ping -n ping-ns -f redis-config.yaml
```

ConfigMap -
Is used to configure all the pods in one place.
In this example a file was used to set the Redis hostname, port and encrypted password in flask-ping/templates/redis-confmap.yaml
```
data:
  redis-host: "redis-master"
  redis-port: "6379"
  redis-pass: "ZjZWU3dsUDlQcA=="
```

These values are implemented within the Flask deployment file:
```
        env:
        - name: REDIS_HOST
          valueFrom:
            configMapKeyRef:
              name: redis-conf
              key: redis-host
        - name: REDIS_PORT
          valueFrom:
            configMapKeyRef:
              name: redis-conf
              key: redis-port
        - name: REDIS_PASSWORD
          valueFrom:
            configMapKeyRef:
              name: redis-conf
              key: redis-pass
```
Then the REDIS_HOST, REDIS_PORT and REDIS_PASSWORD values are set in the pod's os env:

```
kubectl exec -it flask-ping-75bc87b8d7-44vh8 bash -n ping-ns

root@flask-ping-75bc87b8d7-44vh8:/# env | grep REDIS | grep -v MASTER
REDIS_PASSWORD=ZjZWU3dsUDlQcA==
REDIS_HOST=redis-master
REDIS_PORT=6379
```
