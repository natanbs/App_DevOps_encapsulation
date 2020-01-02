# App_DevOps_encapsulation
## Docker-compose Flask with Redis 

A containerized Flask app that query ping to a Redis db and returns pong counts.

With docker-compose you can start / stop the whole env at one. 

To run the app run the commands:

```bash
	docker-compose up -d 
```

To shut down the env:
```bash
	docker-compose down
```

After the containers are up and running, go to the url:

[http://localhost:5000/ping](http://localhost:5000/ping)
