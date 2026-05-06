# ==========================================
# PowerShell Proxy Settings (http://127.0.0.1:7890)
# ==========================================
# 1. Enable Proxy
function pon {
    $Env:http_proxy="http://127.0.0.1:7890"
    $Env:https_proxy="http://127.0.0.1:7890"
    $Env:all_proxy="socks5://127.0.0.1:7890"
    $Env:HTTP_PROXY="http://127.0.0.1:7890"
    $Env:HTTPS_PROXY="http://127.0.0.1:7890"
    $Env:ALL_PROXY="socks5://127.0.0.1:7890"
    Write-Host "-> Proxy Status: ON" -ForegroundColor Green
}

# 2. Disable Proxy
function poff {
    $Env:http_proxy=""
    $Env:https_proxy=""
    $Env:all_proxy=""
    $Env:HTTP_PROXY=""
    $Env:HTTPS_PROXY=""
    $Env:ALL_PROXY=""
    Write-Host "-> Proxy Status: OFF" -ForegroundColor Red
}

# 3. Check Proxy Status
function pstatus {
    if ($Env:http_proxy) {
        Write-Host "-> Current Proxy: ON" -ForegroundColor Green
        Write-Host "  * http_proxy:  $Env:http_proxy"
        Write-Host "  * https_proxy: $Env:https_proxy"
        Write-Host "  * all_proxy:   $Env:all_proxy"
    } else {
        Write-Host "-> Current Proxy: OFF" -ForegroundColor Yellow
    }
}

# ==========================================
# lazygit
# ==========================================
Set-Alias lg lazygit

# ==========================================
# Exit Command
# ==========================================
function q { exit }