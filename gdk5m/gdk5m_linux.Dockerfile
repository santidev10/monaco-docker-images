ARG VERSION=20.04
FROM ubuntu:$VERSION
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt install -y git python3 python-is-python3 build-essential awscli libopengl-dev libva-glx2 libegl1-mesa-dev libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev cmake
# TODO Install Alablas-cli

ENTRYPOINT ["/bin/bash"]
