$lines = [System.IO.File]::ReadAllLines('c:\Users\Lenovo\OneDrive\Tài liệu\Fantasy\server.ps1')
for ($i = 75; $i -lt 110; $i++) {
    Write-Output "$($i+1): $($lines[$i])"
}
