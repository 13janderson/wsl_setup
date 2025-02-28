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
    $distros = wsl --list
    if($distros.Contains($distro)){
        wsl --unregister $distro
    }
}

if($setup){
    wsl -d $distro --exec bash -c "sudo apt update && sudo apt install -y ansible"
    wsl -d $distro --exec bash -c "cd; rm -rf dev_setup; git clone https://github.com/13janderson/dev_setup; cd dev_setup; rm -r install-wsl;cd wsl/init/docker/$distro; bash install-docker.sh"

    # Pop-Location
}