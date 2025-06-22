import random

import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32


class SensorPublisher(Node):
    def __init__(self):
        super().__init__("sensor_publisher")
        self.publisher_ = self.create_publisher(Float32, "temperatura", 10)
        self.timer = self.create_timer(0.5, self.publish_temp)

    def publish_temp(self):
        msg = Float32()
        msg.data = random.uniform(20.0, 30.0)
        self.publisher_.publish(msg)
        self.get_logger().info(f"Temperatura: {msg.data:.2f} °C")


def main(args=None):
    rclpy.init(args=args)
    node = SensorPublisher()
    rclpy.spin(node)
    rclpy.shutdown()
