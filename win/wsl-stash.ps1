param(
    [switch]$pop,
    [string]$distro = "Ubuntu",
    [string]$distroRootDir = "distros"
)


wsl --shutdown

# Idea of this script is to be able to push and pop distros in the same way as git stashing
$importExportPath = "$distroRootDir/$distro.vhdx"
if($pop){
    # Unregister distro if already exists
    $distros = wsl --list
    $distrosMatchingDistro = $distros | Where-Object {$_.StartsWith($distro)}
    if(!($null -eq $distrosMatchingDistro)){
        wsl --unregister $distro
    }

    if(Test-Path -Path $importExportPath){
        wsl --import-in-place $distro $importExportPath
        Remove-item -Path $importExportPath
    }else{
        Write-Host "No distro to import. Try running this script without pop to first export the current distro." -ForegroundColor Red
    }
}else{
    if(!(Test-Path -Path $distroRootDir)){
        New-Item -ItemType Directory -Path $distroRootDir
    }

    # Assume for now only other operation we allow is push
    if(Test-Path -Path $importExportPath){
        $confirmation = Read-Host "An exported distro already exists. Would you like to overwrite it? (y/n)"
        try{
            if($confirmation.ToLower() -eq "y"){
                wsl --export --vhd $distro $importExportPath
            }else{
                return
            }
        } catch{
            return
        }
    }else{
        wsl --export --vhd $distro $importExportPath
    }

}
