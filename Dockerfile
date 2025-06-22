FROM ros:humble

# Instalar dependencias básicas
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    build-essential \
    vim \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Carpeta de trabajo
WORKDIR /ros2_ws

# Default shell para que el entorno ROS funcione correctamente
SHELL ["/bin/bash", "-c"]

# Al entrar, terminal lista para compilar y ejecutar
CMD ["bash"]

