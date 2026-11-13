param(
    [int]$Port = 8080,
    [switch]$NoBrowser
)

$root = $PSScriptRoot
if (-not $root) { $root = (Get-Location).Path }
$root = [System.IO.Path]::GetFullPath($root)

$mimeTypes = @{
    ".html"  = "text/html; charset=utf-8"
    ".htm"   = "text/html; charset=utf-8"
    ".js"    = "application/javascript; charset=utf-8"
    ".mjs"   = "application/javascript; charset=utf-8"
    ".css"   = "text/css; charset=utf-8"
    ".json"  = "application/json; charset=utf-8"
    ".svg"   = "image/svg+xml"
    ".png"   = "image/png"
    ".jpg"   = "image/jpeg"
    ".jpeg"  = "image/jpeg"
    ".webp"  = "image/webp"
    ".gif"   = "image/gif"
    ".ico"   = "image/x-icon"
    ".woff"  = "font/woff"
    ".woff2" = "font/woff2"
    ".ttf"   = "font/ttf"
    ".otf"   = "font/otf"
    ".txt"   = "text/plain; charset=utf-8"
}

$bound = $false
$listener = $null
$actualPort = $Port

for ($p = $Port; $p -le ($Port + 30); $p++) {
    try {
        $prefix = "http://localhost:$p/"
        $testListener = New-Object System.Net.HttpListener
        $testListener.Prefixes.Add($prefix)
        $testListener.Start()
        $listener = $testListener
        $actualPort = $p
        $bound = $true
        break
    } catch {
        # Port is in use or unavailable, try next port
    }
}

if (-not $bound) {
    Write-Error "Could not bind to any port between $Port and $($Port + 30)"
    exit 1
}

$url = "http://localhost:$actualPort/"
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Ashen Press 3D Book Shelf - Localhost Server Running    " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  URL: $url" -ForegroundColor Yellow
Write-Host "  Serving from: $root"
Write-Host "  Press Ctrl+C to stop the server."
Write-Host "==========================================================" -ForegroundColor Cyan

if (-not $NoBrowser) {
    try {
        Start-Process $url
    } catch {}
}

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $urlPath = $request.Url.LocalPath.TrimStart('/')
        if ([string]::IsNullOrWhiteSpace($urlPath)) {
            $urlPath = "index.html"
        }

        # Prevent directory traversal
        $filePath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($root, $urlPath))
        if (-not $filePath.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
            $response.StatusCode = 403
            $bytes = [System.Text.Encoding]::UTF8.GetBytes("403 Forbidden")
            $response.ContentType = "text/plain; charset=utf-8"
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
            $response.Close()
            continue
        }

        if (Test-Path -Path $filePath -PathType Leaf) {
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $mime = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }
            $response.ContentType = $mime
            $response.AddHeader("Access-Control-Allow-Origin", "*")
            $response.AddHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0")
            $response.AddHeader("Pragma", "no-cache")

            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentLength64 = $bytes.Length
            $response.StatusCode = 200

            if ($request.HttpMethod -ne "HEAD") {
                $response.OutputStream.Write($bytes, 0, $bytes.Length)
            }
        } else {
            $response.StatusCode = 404
            $response.ContentType = "text/plain; charset=utf-8"
            $bytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $urlPath")
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        }
        $response.Close()
    }
} catch {
    # Server stopped
} finally {
    if ($listener -and $listener.IsListening) {
        $listener.Stop()
        $listener.Close()
    }
}
