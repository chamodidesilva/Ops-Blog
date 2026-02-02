import os

from flask import Flask
from prometheus_client import Counter, generate_latest

# create a prometheus metric to track hello endpoint calls
REQUEST_COUNT = Counter('hello_request_count', 'Number of hello endpoint calls')

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

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

    # a simple page that says hello
    @app.route('/hello')
    def hello():
        # increment the counter each time the endpoint is called
        REQUEST_COUNT.inc()
        return 'Hello, World!'

    @app.route('/metrics')
    def metrics():
        return generate_latest(), 200, {'Content-Type': 'text/plain'}
    
    from . import db
    db.init_app(app)

    return app
