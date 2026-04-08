#Author : jfgilmore (https://github.com/jfgilmore)

PROMPT='
┌─[%F{blue} %~%f][$(get_ip_address)%f] $(git_prompt_info)
└─➜ '

RPROMPT='[%F{red}%?%f]'

get_ip_address() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    print_linux_ip
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    print_macos_ip
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

print_macos_ip() {
  # Mac OSX
  # https://apple.stackexchange.com/questions/226871/how-can-i-get-the-list-of-all-active-network-interfaces-programmatically/226880#226880
  ipAddress="$(ipconfig getifaddr $(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}'))"

  if [[ -n ipAddress ]]; then
    print_ip $ipAddress
  else
    no_ip
  fi
}

print_linux_ip() {
  if [[ -n "$(ip -o -4 route show to default | awk '{print $9}' 2>/dev/null)" ]]; then
    print_ip "$(ip -o -4 route show to default | awk '{print $9}')"
  else
    no_ip
  fi
}

print_ip() {
  print_in_color 'green' " $1"
}

print_in_color() {
  echo "%{$fg[$1]%}$2%{$reset_color%}"
}
