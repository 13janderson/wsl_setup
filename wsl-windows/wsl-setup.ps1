param(
    [switch]$install,
    [switch]$uninstall,
    [switch]$reinstall,
    [switch]$compile,
    [string]$distro = "Ubuntu"
)


# Generate executables and add to path
$binPath = "$PSScriptRoot\bin"
$userPath = [Environment]::GetEnvironmentVariable("Path","User")
if(!$userPath.Contains($binPath) -or $compile ){
    # Install ps2exe module
    if($null -eq (Get-Module -ListAvailable -Name ps2exe)){
        Install-Module -Name ps2exe -Repository PSGallery -Scope CurrentUser
    }
    $userPathWithBinPath = "$userPath;$binPath"
    [Environment]::SetEnvironmentVariable("Path",$userPathWithBinPath,"User")
    if(!(Test-Path -Path $binPath)){
        New-Item -ItemType Directory -Path $binPath | Out-Null
    }
    $env:path += $binPath
    $files = Get-ChildItem -Path $PSScriptRoot 
    $files | ForEach-Object {
        if($_.Extension -eq ".ps1"){
            ps2exe $_ -outputFile "$binPath/$($_.Name.Replace($_.Extension, '')).exe" -
        }
    }
}else{
}

if(-not ($install -xor $uninstall -xor $setup)){
    exit "only specify one option at once."
}


if($install){
    $distros = wsl --list
    Write-Host $distros
    if($distros | Where-Object{$_.StartsWith($distro)}.Count -eq 0){
        wsl --install -d $distro -n
        write-host "launching new $distro instance. provide login details for default linux user and then type 'logout'." -foregroundcolor green

        # set new distro as default
        wsl --set-default $distro
        # launch new instance which should prompt for default username and password.
        # currently reliant on user exiting this command for us. logout or exit
        wsl -d $distro --cd ~
        write-host "logged out". -foregroundcolor green
    }

    write-host "running setup script for $distro." -foregroundcolor green
    # pull down setup repo into wsl instance
    wsl -d $distro --exec bash -c "cd; git clone https://github.com/13janderson/dev_setup.git; cd dev_setup; cd wsl-linux/init/$distro; sudo bash setup.sh"
    wsl -d $distro --exec bash -c "cd; cd dev_setup; cd dotfiles; cp .* ~;"

    # force use to be in docker group so we can run docker commands w/out sudo
    wsl -d $distro --exec bash -c 'sudo usermod -aG docker $USER'
    wsl -d $distro --shutdown

    wsl -d $distro --cd ~

}

if($uninstall){
    wsl --unregister $distro
}




