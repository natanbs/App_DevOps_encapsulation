# App_DevOps_encapsulation
## Stateful app with redis

Query ping outputs pong counts. The data is stored in a redis DB. 

To run the app run the commands:

```bash
	docker build -t flask-ping:latest .                      # Build Flask docker image
	docker run -d -p 5000:5000 --name Ping-flask flask-ping  # Run the Flask container
	docker run -p 6379:6379 -d --name ping-redis redis       # Run a docker Redis image 
```

After the containers are up and running, go to the url:

[http://localhost:5000/ping](http://localhost:5000/ping)
