install:
	pip install --upgrade pip &&\
	pip install -r requirements-test.txt

install-test:
	pip install -r requirements.txt

test:
	python -m pytest -vv test_hello.py


lint:
	pylint --disable=R,C hello.py

all: install install-test lint test
