FROM ros:humble-ros-base

# Default shell para que funcione `source`
SHELL ["/bin/bash", "-c"]

# Instalar dependencias básicas

RUN apt-get update && apt-get install -y \
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
    python3-pyserial \
    python3-setuptools \
    libxml2-utils \
    libxslt1-dev \
    socat \
    vim \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Carpeta de trabajo
RUN mkdir -p /root/ros2_ws/src
WORKDIR /root/ros2_ws

# Clonar el repositorio del Micro-Agente XRCE-DDS
RUN git clone -b v2.4.2 https://github.com/eProsima/Micro-XRCE-DDS-Agent.git

# Compilar el paquete en el workspace
RUN sourcec /opt/ros/humble/setup.bash && \
    colcon build

# Clonar repositorio de PX4
WORKDIR /root

RUN git clone https://github.com/PX4/PX4-Autopilot.git --recursive

WORKDIR /root/ros2_ws/src

RUN git clone https://github.com/PX4/px4_msgs.git && \
    git clone https://github.com/PX4/px4_ros_com.git

WORKDIR /root/ros2_ws

RUN source /opt/ros/humble/setup.bash && \
    colcon build

WORKDIR /root/PX4-Autopilot

RUN DONT_RUN=1 make px4_sitl gz_x500



# Default shell para que el entorno ROS funcione correctamente
SHELL ["/bin/bash", "-c"]

# Al entrar, terminal lista para compilar y ejecutar
CMD ["bash"]

