import os
import time

from flask import Flask, request, abort, Response
from prometheus_client import Counter, Histogram, generate_latest, Gauge
#from dotenv import load_dotenv

#load_dotenv()

# Prometheus metrics
#endpoint_latency = Histogram('endpoint_latency_seconds', 'Endpoint response time', ['endpoint'])

REQUEST_COUNT = Counter('hello_request_count', 'Number of hello endpoint calls')

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

    #app.config["PROMETHEUS_HEX"] = os.getenv('PROMETHEUS_HEX')

    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # @app.before_request
    # def start_timer():
    #     request.start_time = time.time()

    # @app.after_request
    # def track_metrics(response):
    #     if request.path != '/favicon.ico' and request.path != '/metrics':
    #         # Track load time
    #         latency = time.time() - request.start_time
    #         endpoint_latency.labels(endpoint=request.path).observe(latency)

    #     return response
    
    
    # a simple page that says hello
    @app.route('/hello')
    def hello():
        REQUEST_COUNT.inc()
        return 'Hello, World!'

    @app.route('/metrics')
    def metrics():
        # auth_header = request.headers.get("Authorization")
        # if auth_header is None or not auth_header.startswith("Bearer "):
        #     abort(401)  # Unauthorized if no bearer token is provided

        # token = auth_header.split(" ")[1]
        # if token != app.config["PROMETHEUS_HEX"]:
        #     abort(403)  # Forbidden
        return generate_latest(), 200, {'Content-Type': 'text/plain'}
    
    return app

