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



