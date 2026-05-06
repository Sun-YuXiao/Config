# ==========================================
# vscode
# ==========================================
export PATH="$PATH:/mnt/d/software/vscode/Microsoft VS Code/bin"
export EDITOR='code --wait'

# ==========================================
# WSL2 Proxy & ROS Network Configuration
# ==========================================
export PROXY_PORT=7890
pon() {
    local host_ip=$(ip route show default | awk '{print $3}')
    local wsl_ip=$(hostname -I | awk '{print $1}')
    
    if [ -z "$host_ip" ]; then
        echo -e "\033[1;33m⚠️ 警告: 无法获取 Windows 宿主机 IP。\033[0m"
        return 1
    fi

    export http_proxy="http://${host_ip}:${PROXY_PORT}"
    export https_proxy="http://${host_ip}:${PROXY_PORT}"
    export all_proxy="socks5://${host_ip}:${PROXY_PORT}"

    # ROS 免代理白名单
    local ignore_list="localhost,127.0.0.1,::1,${host_ip},${wsl_ip},$(hostname)"
    export no_proxy="${ignore_list}"
    export NO_PROXY="${ignore_list}"

    echo -e "\033[0;32m✅ 代理已开启 (Proxy ON)\033[0m"
    
    # 极简单行输出 IP 和节点位置
    local ip_info="$(curl -s ipinfo.io/ip) - $(curl -s ipinfo.io/city), $(curl -s ipinfo.io/country)"
    echo -e "\033[0;36m🌍 当前网络:\033[0m ${ip_info}"
}

poff() {
    unset http_proxy https_proxy all_proxy no_proxy NO_PROXY
    echo -e "\033[0;31m❌ 代理已关闭 (Proxy OFF)\033[0m"
}

pstatus() {
    if [ -n "$http_proxy" ]; then
        echo -e "\033[0;32m🟢 代理运行中:\033[0m ${http_proxy}"
        
        # 状态检查时也实时获取一次外网信息
        local ip_info="$(curl -s ipinfo.io/ip) - $(curl -s ipinfo.io/city), $(curl -s ipinfo.io/country)"
        echo -e "\033[0;36m🌍 当前网络:\033[0m ${ip_info}"
    else
        echo "⚪ 代理未开启"
    fi
}

# ==========================================
# ros2
# ==========================================
source /opt/ros/humble/setup.bash


# ==========================================
# codex
# ==========================================
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# opencode
export PATH=/home/syx/.opencode/bin:$PATH

# claude
export PATH="$HOME/.local/bin:$PATH"

# ==========================================
# tmux
# ==========================================
alias tmuxk='tmux kill-session -t'
alias tmuxn='tmux new -s'
alias tmuxa='tmux attach -t'
alias tmuxks='tmux kill-server'

# ==========================================
# yazi
# ==========================================
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ==========================================
# bash
# ==========================================
alias eb='vim ~/.bashrc'
alias sb='source ~/.bashrc'

# ==========================================
# lazygit
# ==========================================
alias lg='lazygit'

# ==========================================
# exit
# ==========================================
alias q='exit'