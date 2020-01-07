## App_DevOps_encapsulation

So your app is app and running, now you want to optimise it. You want the benefit the following:

- Portability - Deploy anywhere
- Isolation - Independency
- Automatic scalability 
- Simple & fast deployment
- Easy rollouts and roll backs.
- High availability
- High performance
- Enhance productivity
- Flexibility
- Predictability
- Improved security

Ok, so you have all the reasons to proceed.
This workshop will guide to implement the following technologies:

- Containerise the app
- Docker-compose
- Kubernetes
- Persistant volumes
- Helm
- Monitoring - Prometheus & Grafana 
- Ingress

## Ping-pong app
We will use a simple Flask app that will return pong to a ping request:
https://github.com/natanbs/App_DevOps_encapsulation/tree/master/v1_flask_app

## Containerise it!
Then we will containerise the app:
https://github.com/natanbs/App_DevOps_encapsulation/tree/master/v2_containerized_flask_app

## Stateless vs stateful
A stateless app component is an app that does not read not write data. With this type of app, we can run many dockers and we don't care if they die.
This concept is essential to understand when we need scalability where we can add or kill dockers according to the usage needs. 
Another implications example is the  rollouts/roll backs where you can incremenly add new dockers with a new version, while incrementsly remove old version ones. 

Statefull app in the other hand reads or stores data. This means we need to know where the data is and which makes the application less portable.
In this case we will need to set up a storage, which is more challenging in the containerised concept and even more with kubernetes.

A typical app that needs to be stateful is a database. For the demonstration, we will make the Ping-pong app to count the amount of ping requests it got.  
The results will be stored in a Redis DB. In this case, if the redis docker fails, the data is lost. Later on we will learn how to maintain the data (pv / pvc)..
https://github.com/natanbs/App_DevOps_encapsulation/tree/master/v3_stateful_app_with_redis_ping_count

## Docker-compose
In the previous scenario, we had to run the flask and the redis dockers manually.
Docker-compose allow you to have both dockers set in one files and with one command start all the whole env with all the components of the application:

https://github.com/natanbs/App_DevOps_encapsulation/tree/master/v4_docker_compose

## Kubernate it ;-)
Now we will migrate the docker-compose to Kubernetes. We will create separate deploy and service file for the app and the db.
This will create each component in a separate pod, yet in the same cluster. 
This will also allow to crerate multiple replicates of the stateless Flask pods while the Redis will have one stateful pod.

In order to pass the redis-host and redis-password to the Flask app from outside of the pods, ConnfigMap was used to pass these vars to the os env.

In the example bellow we will deploy 3 replicas of the Falsk pod and one Redis pod. 

https://github.com/natanbs/App_DevOps_encapsulation/tree/master/v5_kubernate_it

The problem here is that if the redis pod fails, you lose all your data, which is the weakness of a stateful app.
With this we proceed to the next session.

## PersistentVolume (pv) and PersistentVolumeClaims (pvc)
In the previous session if you re-installed the app (or just restarted redis), the data would be lost (ping counts will start all over again).
This is because the data is held within the redis pod. Once the redis dies, the data dies with it.

In order to keep your data safe, we need a mechanism that will keep the data outside of the cluster.
This mechanism inclused two layers:
pv  - A direct communication layer to the storage protocol (like NFS/iSCSI etc). The pv is not attached to any namespace.
pvc - The logical layer that communicates between the pod and the pv. This layer runs in the namespace scope.

Once the pv and pvc and set, then you can set the volume parameters within the pod in the deploy-redis.yml file.

https://github.com/natanbs/App_DevOps_encapsulation/tree/master/v6_pv_pvc_storage

## Helm it!
So what is Helm? what is it good for?
- Simplify the K8s installations
- Centralize the installations
- Source of pre-packaged installations (apt-get style) - only need to manifest the customizewd delta.
- Configuration templating of the projects - Simplifies the project maintainace.
- Template sharing can eliminate duplicated efforts.
- Independency deployment the envs (prod / sandbox / qa are sheer to the deployment)
- Deploying speed

So first we will migrate our Flask original hardcoded code to helm. 
We will copy the original deployment and service manifests to the helm template folder.

For Redis, we will install a pre-packaged installation directly from helm:
```bash
        helm install redis stable/redis -n ping-ns
```
As the Redis installation is cached, you will not find any files.
To view the configurations:

```bash
        helm get all redis -n ping-ns 
```

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

