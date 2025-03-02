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
        wsl --install -d $distro -n
        Write-Host "Launching new $distro instance. Provide login details for default linux user and then type 'logout'." -ForegroundColor Green
        # Set new distro as default
        wsl --set-default -s $distro
        # Launch new instance
        wsl -d $distro 
        Write-Host "Logged out". -ForegroundColor Green
        Write-Host "Installing ansible on WSL." -ForegroundColor Green
        # wsl -d $distro --exec bash -c "sudo apt update && sudo apt install -y ansible"

        Write-Host "Installing docker on WSL." -ForegroundColor Green
        # wsl -d $distro --exec bash -c "curl -fsSL https://get.docker.com -o get-docker.sh; sudo sh get-docker.sh; rm get-docker.sh;"

        Write-Host "Running setup script for $distro." -ForegroundColor Green
        # Pull down setup repo into wsl instance
        # wsl -d $distro --exec bash -c "git clone https://github.com/13janderson/dev_setup.git setup; cp -r dotfiles/. ~/" 
        wsl -d $distro --exec bash -c "cd; git clone https://github.com/13janderson/dev_setup.git; cd dev_setup; cd wsl/init/$distro; sudo bash setup.sh"
        wsl -d $distro --exec bash -c "cd; cd dev_setup; cd dotfiles; cp .* ~;"

    }
}

if($uninstall){
    wsl --unregister $distro
}



