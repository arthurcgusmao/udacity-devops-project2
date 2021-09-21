install:
	pip install --upgrade pip &&\
	pip install -r requirements.txt

install-test:
	pip install -r requirements-test.txt

test:
	python -m pytest -vv test_app.py


lint:
	pylint --disable=R,C app.py

all: install install-test lint test
