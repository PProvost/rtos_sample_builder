FROM mcr.microsoft.com/vscode/devcontainers/base:debian-9
LABEL maintainer="Peter Provost <peter.provost@microsoft.com>"
LABEL Description="Image for building AzureRTOS images using arm-none-eabi-gcc tools"

# This Dockerfile's base image has a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Set up our working directory
WORKDIR /work
ADD . /work

# Pick up the basics
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y -q && \
    apt-get upgrade -y -q && \
    apt-get install -y -q \
        apt-transport-https \
        apt-utils \
        build-essential \
        bzip2 \
        ca-certificates \
        clang-format \
        wget \
        ninja-build \
        cmake  \
        software-properties-common \
        dirmngr \
        lsb-release && \
    if [ "$USER_GID" != "1000" ] || [ "$USER_UID" != "1000" ]; then \
        groupmod --gid $USER_GID $USERNAME \
        && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
        && chown -R $USER_UID:$USER_GID /home/$USERNAME; \
    fi && \
    apt-get autoremove -y && \
    apt-get clean -y -q

# Install CMake 3.15
RUN wget --no-check-certificate https://github.com/Kitware/CMake/releases/download/v3.15.1/cmake-3.15.1-Linux-x86_64.sh \
&& chmod +x cmake-3.15.1-Linux-x86_64.sh \
&& ./cmake-3.15.1-Linux-x86_64.sh --skip-license \
&& rm -rf cmake-3.15.1-Linux-x86_64.sh

# Install newest git client (for proper transport/submodule support)
# RUN add-apt-repository ppa:git-core/ppa && apt-get update -y -q && \
#     apt-get install -y -q git

# Get the ARM GCC build tools
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj

# Update the path to include the new cmake and arm-gcc tools
ENV PATH "/work/bin:/work/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"

# We can use this later when/if we make this a reusable GH action
# ENTRYPOINT [ "/entrypoint.sh" ]

# Drop into bash for interactivity
# CMD [ "/bin/bash" ]