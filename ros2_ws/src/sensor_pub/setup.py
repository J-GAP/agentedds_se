from setuptools import setup

package_name = "sensor_pub"

setup(
    name=package_name,
    version="0.0.0",
    packages=[package_name],
    data_files=[
        ("share/" + package_name, ["package.xml"]),
    ],
    install_requires=["setuptools"],
    zip_safe=True,
    maintainer="Tu Nombre",
    maintainer_email="tu@correo.com",
    description="Ejemplo de nodo publicador",
    license="MIT",
    tests_require=["pytest"],
    entry_points={
        "console_scripts": [
            "sensor_pub_node = sensor_pub.publisher:main",
        ],
    },
)
