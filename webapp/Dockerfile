FROM gliderlabs/alpine:latest

ADD . /webapp
WORKDIR /webapp
RUN apk-install python \
	python-dev \
	py-pip &&\
	pip install -r requirements.txt
CMD ["python", "webapp.py"]
