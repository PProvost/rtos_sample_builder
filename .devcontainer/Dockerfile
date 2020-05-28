FROM ubuntu:18.04
LABEL maintainer="Peter Provost <peter.provost@microsoft.com>"
LABEL Description="Image for building AzureRTOS images using arm-none-eabi-gcc tools"

# Set up our working directory
WORKDIR /work
ADD . /work

# Pick up the basics
RUN apt-get update -y -q && \
    apt-get upgrade -y -q && \
    apt-get install -y -q \
        apt-transport-https \
        apt-utils \
        build-essential \
        bzip2 \
        ca-certificates \
        wget \
        ninja-build \
        cmake  \
        software-properties-common \
        dirmngr \
        lsb-release && \
    apt-get clean -y -q

# Install CMake 3.15
RUN wget --no-check-certificate https://github.com/Kitware/CMake/releases/download/v3.15.1/cmake-3.15.1-Linux-x86_64.sh \
&& chmod +x cmake-3.15.1-Linux-x86_64.sh \
&& ./cmake-3.15.1-Linux-x86_64.sh --skip-license \
&& rm -rf cmake-3.15.1-Linux-x86_64.sh

# Install newest git client (for proper transport/submodule support)
RUN add-apt-repository ppa:git-core/ppa && apt-get update -y -q && \
    apt-get install -y -q git

# Get the ARM GCC build tools
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj

# Update the path to include the new cmake and arm-gcc tools
ENV PATH "/work/bin:/work/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"

# We can use this later when/if we make this a reusable GH action
# ENTRYPOINT [ "/entrypoint.sh" ]

# Drop into bash for interactivity
CMD [ "/bin/bash" ]