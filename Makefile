.DELETE_ON_ERROR:
GENICE=genice2
BASE=genice2_dev
PACKAGE=genice2-dev
all: README.md


prepare: # might require root privilege.
	pip install jinja2


test-deploy: build
	twine upload -r pypitest dist/*
test-install:
	pip install --index-url https://test.pypi.org/simple/ $(PACKAGE)



install:
	python ./setup.py install
uninstall:
	-pip uninstall -y $(PACKAGE)
build: README.md $(wildcard $(BASE)/formats/*.py)
	./setup.py sdist bdist_wheel


deploy: build
	twine upload dist/*
check:
	./setup.py check
clean:
	-rm $(ALL) *~ */*~ *.rdf *.json
	-rm -rf build dist *.egg-info
	-find . -name __pycache__ | xargs rm -rf
