param(
  [switch]$install,
  [switch]$uninstall,
  [string]$distro = "Ubuntu"
)

if(-not ($install -xor $uninstall -xor $setup))
{
  exit "only specify one option at once."
}

if($install)
{
  $distros = wsl --list
  Write-Host $distros
  if($distros | Where-Object{$_.StartsWith($distro)}.Count -eq 0)
  {
    wsl --install -d $distro -n
    write-host "launching new $distro instance. provide login details for default linux user and then type 'logout'." -foregroundcolor green

    # set new distro as default
    wsl --set-default $distro
    # launch new instance which should prompt for default username and password.
    # currently reliant on user exiting this command for us. logout or exit
    wsl -d $distro --cd ~
    Write-Host "logged out". -foregroundcolor green
  }

  Write-Host "running setup script for $distro." -foregroundcolor green
  # pull down setup repo into wsl instance
  wsl -d $distro --exec bash -c "cd; git clone https://github.com/13janderson/wsl_setup.git; cd wsl_setup/linux; sudo bash setup.sh"

  # Run dfd script to copy down dotfiles to $HOME
  wsl -d $distro --exec bash -c "cd; source ./wsl_setup/dotfiles/.local/bin/scripts/dfd.sh"

  # Restart
  wsl -d $distro --shutdown
  wsl -d $distro --cd ~

}

if($uninstall)
{
  wsl --unregister $distro
}




