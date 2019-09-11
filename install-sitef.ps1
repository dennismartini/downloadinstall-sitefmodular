$ErrorActionPreference = "Stop"
$versao = $args[0]
$url = $args[1]
$tefpath = "c:\client\clientsitef.exe"
$tefpathtest = Test-Path $tefpath
if( $tefpathtest -eq "True"){
$versaoatual = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("c:\client\clientsitef.exe").FileVersion
$novaversao = $versao
if($versaoatual -ne $novaversao){
    Install-Module -Name Microsoft.PowerShell.Archive
    write-output "Baixando cliente modular Sitef"
    $output = "c:\puppet\arquivos\$versao.zip"
    $start_time = Get-Date  
    Invoke-WebRequest -Uri $url -OutFile $output
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
    Expand-Archive -LiteralPath C:\puppet\arquivos\$versao.zip -DestinationPath C:\puppet\arquivos\$versao -Force
    $fullpath = Get-ChildItem "c:\puppet\arquivos\$versao" -Recurse -Include *$versao* | Where-Object { ! $_.PSIsContainer } | ForEach-Object { Write-output $_.FullName }
    $fullpath = """" + "$fullpath" + """"
    (Start-Process -FilePath "msiexec.exe" -ArgumentList "/passive /i $fullpath TARGETDIR=C:\Client REINSTALLMODE=amus INSTALLDIR=C:\Client" -Wait -Passthru).ExitCode
}else {
   write-host("Sitef encontra-se atualizado")
}
}else{
    Install-Module -Name Microsoft.PowerShell.Archive
    write-output "Baixando cliente modular Sitef"
    $output = "c:\puppet\arquivos\$versao.zip"
    $start_time = Get-Date  
    Invoke-WebRequest -Uri $url -OutFile $output
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
    Expand-Archive -LiteralPath C:\puppet\arquivos\$versao.zip -DestinationPath C:\puppet\arquivos\$versao -Force
    $fullpath = Get-ChildItem "c:\puppet\arquivos\$versao" -Recurse -Include *$versao* | Where-Object { ! $_.PSIsContainer } | ForEach-Object { Write-output $_.FullName }
    $fullpath = """" + "$fullpath" + """"
    (Start-Process -FilePath "msiexec.exe" -ArgumentList "/passive /i $fullpath TARGETDIR=C:\Client REINSTALLMODE=amus INSTALLDIR=C:\Client" -Wait -Passthru).ExitCode

}