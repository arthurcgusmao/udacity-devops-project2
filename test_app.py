import io
import json
import pytest
import time

from app import app


@pytest.fixture(scope="session")
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


@pytest.fixture(scope="session")
def input_data():
    return {
        "CHAS": {"0": 0},
        "RM": {"0": 6.575},
        "TAX": {"0": 296.0},
        "PTRATIO": {"0": 15.3},
        "B": {"0": 396.9},
        "LSTAT": {"0": 4.98}
    }


def test_predict(client, input_data):
    rv = client.post("/predict", json=input_data)
    pred = json.load(io.BytesIO(rv.data))['prediction'][0]
    assert pred == pytest.approx(20.35, rel=1e-2)
