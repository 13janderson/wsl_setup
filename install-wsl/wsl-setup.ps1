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
    Write-Host "Installing ansible on WSL." -ForegroundColor Green
    # wsl -d $distro --exec bash -c "sudo apt update && sudo apt install -y ansible"

    Write-Host "Installing docker on WSL." -ForegroundColor Green
    # wsl -d $distro --exec bash -c "curl -fsSL https://get.docker.com -o get-docker.sh; sudo sh get-docker.sh; rm get-docker.sh;"

    Write-Host "Running setup script for $distro." -ForegroundColor Green
    # Pull down setup repo into wsl instance
    wsl -d $distro --exec bash -c "git clone https://github.com/13janderson/dev_setup.git setup; cp -r dotfiles/. ~/" 
    # wsl -d $distro --exec bash "git clone https://github.com/13janderson/dev_setup setup; cd setup; cd wsl/init/$distro; bash setup.sh"


}


