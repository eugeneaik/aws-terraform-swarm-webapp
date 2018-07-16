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
    container_dict = {'ab724b9715eb99afed3c0a893557eb13e57ca8575e746951233a6a4a452e8d4c': 'busybox', '92434e11e415a6ec197348b841541b1e38cbc6ec9112e15e1456791e884cddbe': 'registry:2@sha256:51bb55f23ef7e25ac9b8313b139a8dd45baa832943c8ad8f7da2ddad6355b3c8'}

    return render_template('index.html',version=version, mydict=container_dict)

@app.route('/info')
def dockerinfo():
    v=(client.version()).get('Version')
    return v

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
