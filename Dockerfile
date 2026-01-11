FROM debian:stable-slim

ARG DEBIAN_FRONTEND=noninteractive

# Core tools and Node.js (via NodeSource)
RUN apt-get update && \
    apt-get install -y curl ca-certificates gnupg bash sudo wget vim xclip less \
       unzip bzip2 xz-utils 

RUN curl -fsSL https://deb.nodesource.com/setup_25.x | bash - && \
    apt-get install -y nodejs

RUN npm i -g opencode-ai


RUN useradd -m -s /bin/bash ethos
RUN echo "ethos ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ethos && chmod 440 /etc/sudoers.d/ethos
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


USER ethos
WORKDIR /home/ethos

ENTRYPOINT ["/entrypoint.sh"]
