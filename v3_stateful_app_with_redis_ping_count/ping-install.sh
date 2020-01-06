docker network create ping-net
docker build -t flask-ping:v1.0.0 .
docker run -d -p 5000:5000 --name ping-flask --network='ping-net' flask-ping:v1.0.0 
docker run -p 6379:6379 -d --name ping-redis --network='ping-net' redis 
