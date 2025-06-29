buildTag="ubuntu"
nameTag="devbox"
docker build -t $buildTag .
docker stop $nameTag > /dev/null 2>&1
docker rm $nameTag > /dev/null 2>&1
docker run -it --name $nameTag $buildTag bash -c "cd; git clone https://github.com/13janderson/dev_setup.git; cd dev_setup/linux/init/Ubuntu; sudo ./setup.sh; source ./dev_setup/dotfiles/.local/bin/scripts/dfd.sh; echo 'sleeping'; tail -f /dev/null"
