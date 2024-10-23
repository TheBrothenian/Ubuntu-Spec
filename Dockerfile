# Dockerfile
FROM ubuntu:20.04

# Update the package list and install Ansible dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible && \
    apt-get clean

# Create a non-root user
RUN useradd -m myuser

# Set the user to use when running the image
USER myuser

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Add HEALTHCHECK instruction
HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost/ || exit 1

CMD ["/bin/bash"]
