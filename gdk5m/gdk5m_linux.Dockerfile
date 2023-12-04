ARG VERSION=22.04
FROM ubuntu:$VERSION
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt install -y git python3 python-is-python3 build-essential pkg-config autoconf-archive awscli libx11-dev libopengl-dev libva-glx2 libegl1-mesa-dev libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev wget apt-transport-https software-properties-common && apt clean all
RUN apt purge -y --auto-remove cmake
RUN wget -q https://packages.microsoft.com/config/ubuntu/$VERSION/packages-microsoft-prod.deb
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ jammy main'
RUN rm packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y powershell cmake=3.26.4-0kitware1ubuntu22.04.1 cmake-data=3.26.4-0kitware1ubuntu22.04.1

# TODO Install Alablas-cli
ENTRYPOINT ["/bin/bash"]
