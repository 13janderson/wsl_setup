FROM ubuntu:24.04
RUN apt-get update

RUN apt-get update && apt-get install -y \
  sudo \
  curl \
  git

ARG USERNAME=test
ARG PASSWORD=pass

RUN useradd -m -s /bin/bash $USERNAME \
  && echo "$USERNAME:$PASSWORD" | chpasswd \
  && adduser $USERNAME sudo

# Allow passwordless sudo for this user
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

# Optional: Set default user
USER $USERNAME
WORKDIR /home/$USERNAME


