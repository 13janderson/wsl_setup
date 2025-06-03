# Python3 already installed on machine
# Alias python to python3
alias python="python3"

# Install pip
sudo apt-get install python3-pip

# Install virtual env
sudo apt install python3.12-venv

# Install poetry
sudo apt-get install python3-poetry

# Install pyenv
curl -fsSL https://pyenv.run | bash
# Pyenv build dependencies
sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install pyenv dependencies
sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
