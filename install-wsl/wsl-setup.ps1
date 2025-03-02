param(
    [switch]$install,
    [switch]$uninstall,
    [switch]$setup,
    [string]$distro = "Ubuntu"
)

if(-not ($install -xor $uninstall -xor $setup)){
    exit "Only specify one option at once."
}


if($install){
    $distros = wsl --list
    if(-not $distros.Contains($distro)){
        wsl --install -d $distro
    }
}

if($uninstall){
    wsl --unregister $distro
}

if($setup){
    wsl -d $distro --exec bash -c "sudo apt update && sudo apt install -y ansible"
    wsl -d $distro --exec bash -c "curl -fsSL https://get.docker.com -o get-docker.sh; sudo sh get-docker.sh; rm get-docker.sh;"

    # Pull down setup repo into wsl instance
    wsl -d $distro --exec bash "git pull https://github.com/13janderson/dev_setup setup; cd setup; rm -rf install-wsl; cd wsl/init/$distro; bash setup.sh"



}


