# Dockerfile
FROM ubuntu:20.04

# Update the package list and install Ansible dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible && \
    apt-get clean

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

CMD ["/bin/bash"]
