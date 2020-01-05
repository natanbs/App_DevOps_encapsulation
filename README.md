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

## Containerise
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

## Kubernate it!
Now we will migrate the docker-compose to Kubernetes. We will create separate deploy and service file for the app and the db.
This will create each component in a separate pod, yet in the same cluster. 
This will also allow to crerate multiple replicates of the stateless Flask pods while the Redis will have one stateful pod.
In the example bellow we will deploy 3 replicas of the Falsk pod and one Redis pod. 

https://github.com/natanbs/App_DevOps_encapsulation/tree/master/v5_kubernate_it

