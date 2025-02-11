FROM jenkins/jenkins:2.426.1-jdk11

USER root

# Update system and install dependencies
RUN apt-get update && apt-get install -y \
  lsb-release \
  python3 \
  python3-pip \
  ca-certificates \
  curl \
  gnupg

# Ensure Python is accessible by the Jenkins user
RUN ln -s /usr/bin/python3 /usr/bin/python

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | tee /usr/share/keyrings/docker-archive-keyring.asc > /dev/null

# Set up the Docker repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Switch back to Jenkins user
USER jenkins

# Install required Jenkins plugins (latest versions)
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
