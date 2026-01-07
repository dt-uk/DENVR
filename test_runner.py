import docker, pytest, sys
client = docker.from_env()
print("Containerized Test Runner Initialized")
def run_container_test(image, cmd):
    container = client.containers.run(image, cmd, remove=True)
    return container.decode('utf-8')
