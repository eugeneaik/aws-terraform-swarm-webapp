from flask import Flask, redirect, render_template
import docker

client = docker.from_env()
container_dict = {}

app = Flask(__name__)

def get_containers(): 
    for container in client.containers.list():
        container_dict[container.id] = container.attrs['Config']['Image']

@app.route('/')
def mainpage():
    version = (client.version()).get('Version')
    get_containers()
    container_dict['test'] = 'test'
    return render_template('index.html',version=version, mydict=container_dict)

@app.route('/info')
def dockerinfo():
    v=(client.version()).get('Version')
    return v

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
