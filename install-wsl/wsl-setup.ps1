param(
    [switch]$install,
    [switch]$uninstall,
    [switch]$reinstall,
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
        wsl --set-default $distro
        # Launch new instance which should prompt for default username and password.
        # Currently reliant on user exiting this command for us. logout or exit
        wsl -d $distro --cd ~
        Write-Host "Logged out". -ForegroundColor Green

        Write-Host "Running setup script for $distro." -ForegroundColor Green
        # Pull down setup repo into wsl instance
        wsl -d $distro --exec bash -c "git clone https://github.com/13janderson/dev_setup.git setup;" 
        wsl -d $distro --exec bash -c "cd; git clone https://github.com/13janderson/dev_setup.git; cd dev_setup; cd wsl/init/$distro; sudo bash setup.sh"
        wsl -d $distro --exec bash -c "cd; cd dev_setup; cd dotfiles; cp .* ~;"

        Write-Host "Adding user to docker group and restarting." -ForegroundColor Green
        # Force use to be in docker group so we can run docker commands w/out sudo
        wsl -d $distro --cd ~

    }
}

if($uninstall){
    wsl --unregister $distro
}




