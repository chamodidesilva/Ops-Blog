import pytest 
from flaskr import create_app

@pytest.fixture
def client():
    app = create_app({
        "TESTING": True,
    })

    with app.test_client() as client:
        yield client

def test_endpoint_hello(client):
    response = client.get("/hello")

    assert response.status_code == 200
    assert response.data.decode("utf-8") == "Hello, World!"

    