#Author : jfgilmore (https://github.com/jfgilmore)

PROMPT='
┌─[%F{blue} %~%f] [%F{green} $(get_ip_address)%f] $(git_prompt_info)
└─➜ '

RPROMPT='[%F{red}%?%f][%F{green}%T%f]'

get_ip_address() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ -n "$(ifconfig tun0 2>/dev/null)" ]]; then
      echo "%{$fg[green]%}$(ifconfig tun0 | awk '/inet / {print $2}')%{$reset_color%}"
    elif [[ -n "$(ifconfig wlan0 2>/dev/null)" ]]; then
      echo "%{$fg[green]%}$(ifconfig wlan0 | awk '/inet / {print $2}')%{$reset_color%}"
    elif [[ -n "$(ifconfig wlp6s0 2>/dev/null)" ]]; then
      echo "%{$fg[green]%}$(ifconfig wlp6s0 | awk '/inet / {print $2}')%{$reset_color%}"
    else
      echo "%{$fg[red]%}No IP%{$reset_color%}"
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    # https://apple.stackexchange.com/questions/226871/how-can-i-get-the-list-of-all-active-network-interfaces-programmatically/226880#226880
            ipAddress="$(ipconfig getifaddr $(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}'))"
    if [[ -n ipAddress ]]; then
      echo "%{$fg[green]%}$ipAddress"
    else
      echo "%{$fg[red]%}No IP%{$reset_color%}"
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


