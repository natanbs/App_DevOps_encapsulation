# Ping pong
## Kubernated Flask with Redis 

Kubernates with Flask apps that query ping to a Redis db (separate pods) and returns pong counts.

To run the app run the commands:

```bash
	./ping-install.sh
	./ping-unstall.sh
```

To check the service IP:
```bash
        kubectl get svc | grep flask | awk '{print $4}'
```

After the containers are up and running, go to the url:

[http://{IP}:5000/ping](http://localhost:5000/ping)
