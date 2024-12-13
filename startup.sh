#!/bin/bash

# Navigate to the deployment folder
cd /home/site/wwwroot

# Install necessary dependencies (Java and others)
apt-get update && apt-get install -y software-properties-common
apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
apt-get update && apt-get install -y openjdk-8-jdk wget

# Set JAVA_HOME and PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Verify Java installation
echo "Java version:"
java -version

# Download and setup Apache Spark
SPARK_VERSION="3.5.0"  # Change this to your desired Spark version
HADOOP_VERSION="3"     # Adjust the Hadoop version as needed
SPARK_DIR="/opt/spark"

# If Spark is not already downloaded
if [ ! -d "$SPARK_DIR" ]; then
    echo "Downloading Apache Spark..."
    wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -O spark.tgz
    tar -xvzf spark.tgz
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} $SPARK_DIR
    rm spark.tgz
fi

# Set Spark environment variables
export SPARK_HOME=$SPARK_DIR
export PATH=$SPARK_HOME/bin:$PATH
export PYSPARK_PYTHON=python3
export PYSPARK_DRIVER_PYTHON=python3

# Verify Spark installation
echo "Spark version:"
spark-submit --version

# Run the Streamlit app
echo "Running Streamlit app..."
python -m streamlit run /home/site/wwwroot/main.py --server.port 8000 --server.address 0.0.0.0
