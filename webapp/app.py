from flask import Flask
import docker
from pprint import pprint

mydocker = docker.from_env()

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello Docker"

@app.route('/info')
def dockerinfo():
    return mydocker.info()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
