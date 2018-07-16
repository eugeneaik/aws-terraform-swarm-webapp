from flask import Flask, redirect, render_template
import docker

mydocker = docker.from_env()
container_dict = {}

app = Flask(__name__)

def get_ontainers(): 
    for container in client.containers.list():
	container_dict[container.id] =container.attrs['Config']['Image']

@app.route('/')
def mainpage():
    version = (mydocker.version()).get('Version')
    get_containers()
    return render_template('index.html',version=version, mydict=mydict)

@app.route('/info')
def dockerinfo():
    v=(mydocker.version()).get('Version')
    return v

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
