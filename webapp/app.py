from flask import Flask, redirect, render_template
import docker

client = docker.from_env()
container_dict = {}
service_dict = {}

app = Flask(__name__)

def get_containers(): 
    for container in client.containers.list():
        container_dict[container.id] = container.attrs['Config']['Image']

def get_services():
    for service in service.containers.list():
        service_dict[service.id] = "noname"

@app.route('/')
def mainpage():
    version = (client.version()).get('Version')
    get_containers()
    get_services()
    return render_template('index.html',version=version, dcontainer=container_dict, dservice=service_dict)

@app.route('/info')
def dockerinfo():
    v=(client.version()).get('Version')
    return v

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
