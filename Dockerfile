FROM jenkins/jenkins:2.414.2-jdk11

USER root

# Update system and install dependencies
RUN apt-get update && apt-get install -y \
  lsb-release \
  python3-pip \
  ca-certificates \
  curl \
  gnupg

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | tee /usr/share/keyrings/docker-archive-keyring.asc > /dev/null

# Set up the Docker repository (hardcoded for compatibility)
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Switch back to Jenkins user
USER jenkins

# Install required Jenkins plugins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"
