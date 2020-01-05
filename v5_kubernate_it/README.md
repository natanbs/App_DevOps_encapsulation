# App_DevOps_encapsulation
## Kubernated Flask with Redis 

Kubernates with Flask apps that query ping to a Redis db (separate pods) and returns pong counts.

In this exaple we used 3 replicas that can be canged within deploy file with the parameter:
replicas: 3

The env is created in the namespace ping-ns (namespace.yml)

To run the app run the commands:

```bash
	./ping-install.sh
	./ping-unstall.sh
```

To check the service IP:
```bash
        kubectl get svc -n ping-ns | grep flask | awk '{print $4}'
```

After the containers are up and running, go to the url:

[http://{IP}:5000/ping](http://localhost:5000/ping)
