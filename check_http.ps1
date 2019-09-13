# Create the request
$ErrorActionPreference = "SilentlyContinue"
function httptest {
Param($url)
$HTTP_Request = [System.Net.WebRequest]::Create("$url")
# Get the response
$HTTP_Response = $HTTP_Request.GetResponse()
# Get the HTTP as a interger
$HTTP_Status = [int]$HTTP_Response.StatusCode
If ($HTTP_Status -eq 200) {
    write-output "1"
}
Else {
    write-output "0"
}
# Clean up and close the request.
$HTTP_Response.Close()
}
$argurl = $args[0]
$argmsg = $args[1]
$teste1 = httptest -url $argurl
write-output $teste1
Start-Sleep 1
$teste2 = httptest -url $argurl
write-output $teste2
Start-Sleep 1
$teste3 = httptest -url $argurl
write-output $teste3
Start-Sleep 1
$teste4 = httptest -url $argurl
write-output $teste4
Start-Sleep 1
$result = $teste1+$teste2+$teste3+$teste4
write-output $result

if ($result -eq "0000" ) {
    Start-Sleep 2
    $teste1 = httptest -url "https://www.google.com"
    write-output $teste1
    Start-Sleep 2
    $teste2 = httptest -url "https://www.google.com"
    write-output $teste2
    Start-Sleep 2
    $teste3 = httptest -url "https://www.google.com"
    write-output $teste3
    Start-Sleep 2
    $teste4 = httptest -url "https://www.google.com"
    write-output $teste4
    Start-Sleep 2
    $result = $teste1+$teste2+$teste3+$teste4
    if ($result -eq "0000" ) {
    write-output "Ocorreram falhas"
    $usernames = Get-ChildItem c:\users -directory | ForEach-Object { Write-output $_.Name }
    ForEach ($line in $($usernames -split "`r`n")) { msg $line HOUVERAM FALHAS DE CONEXAO COM A INTERNET, VERIFIQUE SE SUA INTERNET ESTA FUNCIONAL }
    } else {
    $usernames = Get-ChildItem c:\users -directory | ForEach-Object { Write-output $_.Name }
    ForEach ($line in $($usernames -split "`r`n")) { msg $line $argmsg }
    }
} else {
    write-output "Teste OK"
}