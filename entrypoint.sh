#!/bin/bash

# Set ROS distribution
# This variable defines the ROS 2 distribution being used (e.g., "jazzy", "rolling", etc.)
ROS_DISTRO="humble"

# Set base paths for convenience
# ROS_WS is the path to the ROS 2 workspace
ROS_WS="/root/ros2_ws"

cd $ROS_WS

# Source ROS setup file
# This sets up the ROS 2 environment for the current shell session
source /opt/ros/$ROS_DISTRO/setup.bash

# Build the ROS 2 workspace using colcon
colcon build

# Source the local workspace setup
source $ROS_WS/install/setup.bash

# Any command you run after this script runs in the environment set up by the script.
exec "$@"
