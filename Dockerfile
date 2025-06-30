FROM ros:humble-ros-base

SHELL ["/bin/bash", "-c"]

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

RUN mkdir -p /root/ros2_ws/src
WORKDIR /root/ros2_ws

RUN git clone -b v2.4.2 https://github.com/eProsima/Micro-XRCE-DDS-Agent.git && \
    git clone https://github.com/PX4/px4_msgs.git src/px4_msgs && \
    git clone https://github.com/PX4/px4_ros_com.git src/px4_ros_com && \
    git clone https://github.com/PX4/PX4-Autopilot.git --recursive /root/PX4-Autopilot

# Compilar todo el workspace ROS 2 en una única capa
RUN source /opt/ros/humble/setup.bash && \
    colcon build

# Agregar los entornos ROS al bash por defecto
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc

WORKDIR /root
CMD ["bash"]

