from flask import Flask
import docker
from pprint import pprint

mydocker = docker.from_env()

app = Flask(__name__)

@app.route('/')
def mainpage():
    v=(mydocker.version()).get('Version')
    return "Hello Docker version %v", v

@app.route('/info')
def dockerinfo():
    v=(mydocker.version()).get('Version')
    return v

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
