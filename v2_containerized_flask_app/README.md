# App_DevOps_encapsulation
## Containerized Flask Application 

A containerized Flask app that returns pong to a ping request.

Create a Dockerfile and a requirements.txt accordingly. Then build the image and run the docker from that image.

To run the app run the commands:

```bash
	docker build -t flask-ping:latest .                      # Build the docker image
	docker run -d -p 5000:5000 --name ping-flask flask-ping  # Run the Flask container
```
Flags: -t: target name. -d: daemon. -p: redirect local port to docker port 

After the application is running go to the url:

[http://localhost:5000/ping](http://localhost:5000/ping)
