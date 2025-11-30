import os
import time

from flask import Flask, request, abort, Response
from prometheus_client import Counter, Histogram, generate_latest, Gauge
from dotenv import load_dotenv

# print("Prometheus client loaded from:", prometheus_client.__file__)

# load_dotenv(dotenv_path="../secrets/.env")

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

    hello_counter = Counter('hello_request_count', 'Number of hello endpoint calls')
    # app.config["PROMETHEUS_HEX"] = os.getenv('PROMETHEUS_HEX')

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

    @app.route('/hello')
    def hello():
        hello_counter.inc()
        return 'Hello, World!'

    @app.route('/metrics')
    def metrics():
        return generate_latest()
        # auth_header = request.headers.get("Authorization")
        # if auth_header is None or not auth_header.startswith("Bearer "):
        #     abort(401)  # Unauthorized if no bearer token is provided

        # token = auth_header.split(" ")[1]
        # if token != app.config["PROMETHEUS_HEX"]:
        #     abort(403)  # Forbidden
        # return generate_latest(), 200, {'Content-Type': 'text/plain'}

    
    return app

