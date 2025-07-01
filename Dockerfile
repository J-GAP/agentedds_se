FROM ros:humble-ros-base

SHELL ["/bin/bash", "-c"]

# 1. Instala dependencias básicas
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    git \
    wget \
    curl \
    python3-pip \
    libasio-dev \
    libtinyxml2-dev \
    libfoonathan-memory-dev \
    socat \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# 2. Instala fastcdr v2.2.0
RUN cd ~ && \
    git clone https://github.com/eProsima/fastcdr.git -b v2.2.0 && \
    cd fastcdr && mkdir build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j$(nproc) && make install

# 3. Instala fastdds v3.2.2
RUN cd ~ && \
    git clone https://github.com/eProsima/Fast-DDS.git -b v3.2.2 && \
    cd Fast-DDS && mkdir build && cd build && \
    cmake .. \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_PREFIX_PATH="/usr/local" \
      -Dfastcdr_DIR=/usr/local/lib/cmake/fastcdr && \
    make -j$(nproc) && make install

# 4. Actualiza cache de bibliotecas del sistema
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/fastdds.conf && \
    ldconfig

# 5. Prepara workspace ROS 2
RUN mkdir -p /root/ros2_ws/src
WORKDIR /root/ros2_ws

# 6. Clona repos Micro XRCE-DDS y PX4
RUN git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git src/MicroXRCEAgent && \
    git clone https://github.com/PX4/px4_msgs.git src/px4_msgs && \
    git clone https://github.com/PX4/px4_ros_com.git src/px4_ros_com

# 7. Compila el workspace ROS 2
RUN source /opt/ros/humble/setup.bash && \
    colcon build --cmake-clean-cache --cmake-args -DCMAKE_PREFIX_PATH=/usr/local

# 8. Configura entorno para bash interactivo
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc

# 9. Carpeta por defecto
WORKDIR /root

# 10. Shell lista para usar
CMD ["bash"]

