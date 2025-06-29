FROM ros:humble-ros-base

# Default shell para que funcione `source`
SHELL ["/bin/bash", "-c"]

# Instalar dependencias básicas

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      ninja-build \
      git \
      wget \
      curl \
      python3-pip \
      python3-jinja2 \
      python3-empy \
      python3-toml \
      python3-numpy \
      python3-yaml \
      python3-dev \
      python3-setuptools \
      libxml2-utils \
      libxslt1-dev \
      socat \
      net-tools \
      iputils-ping && \
    rm -rf /var/lib/apt/lists/*

# Carpeta de trabajo
RUN mkdir -p /root/ros2_ws/src
WORKDIR /root/ros2_ws

# Clonar repositorios necesarios en el workspace
RUN git clone -b v2.4.2 https://github.com/eProsima/Micro-XRCE-DDS-Agent.git && \
    git clone https://github.com/PX4/px4_msgs.git /root/ros2_ws/src/px4_msgs && \
    git clone https://github.com/PX4/px4_ros_com.git /root/ros2_ws/src/px4_ros_com    
# Clonar repositorio de PX4
    
RUN git clone https://github.com/PX4/PX4-Autopilot.git --recursive /root/PX4-Autopilot

# Directorio de trabajo por defecto
WORKDIR /root

# Entrypoint para compilar/ejecutar manualmente
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

# Set the entrypoint for the container
# This script will be run every time the container starts
ENTRYPOINT ["/root/entrypoint.sh"]

# Al entrar, terminal lista para compilar y ejecutar
CMD ["bash"]

