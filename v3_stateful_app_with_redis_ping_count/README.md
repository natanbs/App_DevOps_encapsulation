# App_DevOps_encapsulation
## Stateful app with redis

Query ping outputs pong counts. The data is stored in a redis DB. 

To run the app run the commands:

```bash
        docker network create ping-net                                                       # Create a network env for the containers to communicate
	docker build -t flask-ping:v1.0.0 .                                                  # Build Flask docker image
	docker run -d -p 5000:5000 --name ping-flask --network='ping-net' flask-ping:v1.0.0  # Run the Flask container
	docker run -p 6379:6379 -d --name ping-redis --network='ping-net' redis              # Run a docker Redis image 
```

After the containers are up and running, go to the url:

[http://localhost:5000/ping](http://localhost:5000/ping)
