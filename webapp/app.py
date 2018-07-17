from flask import Flask, redirect, render_template
import docker

client = docker.DockerClient(base_url='unix://var/run/docker.sock', version='auto') 
container_dict = {}
service_dict = {}

app = Flask(__name__)

def get_containers():
    for i_container in client.containers.list():
        container_dict[i_container.id] = i_container.attrs['Config']['Image']

def get_services():
    for i_service in client.services.list():
        service_dict[i_service.id] = i_service.attrs['Spec']['TaskTemplate']['ContainerSpec']['Image']
def get_logs(id):
    container = client.containers.get(id)
    return container.logs()

@app.route('/')
def mainpage():
    version = (client.version()).get('Version')
    apiver = (client.version()).get('ApiVersion')
    get_containers()
#    get_services()
    return render_template('index.html',version=version, api=apiver, dcontainer=container_dict, dservice=service_dict)

@app.route('/container/<string:id>')
def containerinfo(id):
    logs = get_logs(id)
    logs = logs.decode('utf-8').splitlines()
    return render_template('logs.html',id=id, logs=logs)

@app.route('/info')
def dockerinfo():
    v=(client.version()).get('Version')
    return v

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
