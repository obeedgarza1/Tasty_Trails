#!/bin/bash

# Navigate to the directory where output.tar.gz is located
cd /home/site/wwwroot  # Adjust if necessary

# Extract the tar.gz file
tar -xzvf output.tar.gz -C /tmp/8dd1b06a7f764f8

# Install necessary dependencies (Java and others)
apt-get update && apt-get install -y software-properties-common
apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
apt-get update && apt-get install -y openjdk-8-jdk

# Set JAVA_HOME and PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Verify Java installation
echo "Java version:"
java -version

# Run the Streamlit app
echo "Running Streamlit app..."
streamlit run /home/site/wwwroot/main.py --server.port 8000 --server.address 0.0.0.0  # Adjust as needed