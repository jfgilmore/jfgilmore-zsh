#Author : jfgilmore (https://github.com/jfgilmore)

PROMPT='
┌─[%F{blue} %~%f][$(get_ip_address)%f] $(git_prompt_info)
└─➜ '

RPROMPT='[%F{red}%?%f]'

get_ip_address() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ -n "$(ifconfig tun0 2>/dev/null)" ]]; then
      print_linux_ip 'tun0'
    elif [[ -n "$(ifconfig wlan0 2>/dev/null)" ]]; then
      print_linux_ip 'wlan0'
    elif [[ -n "$(ifconfig wlp6s0 2>/dev/null)" ]]; then
      print_linux_ip 'wlp6s0'
    else
      no_ip
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    # https://apple.stackexchange.com/questions/226871/how-can-i-get-the-list-of-all-active-network-interfaces-programmatically/226880#226880
    ipAddress="$(ipconfig getifaddr $(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}'))"

    if [[ -n ipAddress ]]; then
      print_ip $ipAddress
    else
      no_ip
    fi
  elif [[ "$OSTYPE" == "cygwin" ]]; then
          # POSIX compatibility layer and Linux environment emulation for Windows
  elif [[ "$OSTYPE" == "msys" ]]; then
          # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
  elif [[ "$OSTYPE" == "win32" ]]; then
          # I'm not sure this can happen.
  elif [[ "$OSTYPE" == "freebsd"* ]]; then
          # ...
  else
          # Unknown.
  fi
}

no_ip() {
  print_in_color 'red' "󰖪 no IP"
}

print_linux_ip() {
  print_ip "$(ifconfig $1 | awk '/inet / {print $2}')"
}

print_ip() {
  print_in_color 'green' " $1"
}

print_in_color() {
  echo "%{$fg[$1]%}$2%{$reset_color%}"
}