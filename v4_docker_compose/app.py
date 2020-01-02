from flask import Flask
import redis
app = Flask(__name__)

redis_host = "ping-redis"
redis_port = 6379
redis_password = ""

@app.route('/')
def hi():
    return "Hello!"

@app.route('/test')
def test_conn():
    try:
        r = redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, decode_responses=True)
        rs = r.client_list()  # Check redis connection
        return('Success')       
   
    except Exception as e:
        #print(e)
        return('Failed')

@app.route('/ping')
def ping():
    try:
        r = redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, decode_responses=True)
        rs = r.client_list()
        pong = r.get('ping')
        if pong == None:
          pong = 1
          r.set("ping", pong)
        else:
          pong = int(pong)
          pong += 1
          r.set("ping", pong)
        pong = r.get('ping')
        return(pong)

    except Exception as e:
        #print(e)
        return('Failed')

@app.route('/del_ping')
def del_ping():
    try:
        r = redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, decode_responses=True)
#        rs = r.client_list()
        r.delete('ping')

    except Exception as e:
        #print(e)
        return('Failed')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
