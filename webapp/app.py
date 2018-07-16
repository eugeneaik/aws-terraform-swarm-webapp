from flask import Flask, redirect, render_template
import docker
from pprint import pprint

mydocker = docker.from_env()

app = Flask(__name__)

@app.route('/')
def mainpage():
    version = (mydocker.version()).get('Version')
    return render_template('index.html',version=version)

@app.route('/info')
def dockerinfo():
    v=(mydocker.version()).get('Version')
    return v

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
