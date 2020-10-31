function _git_prpt() {
  local _out=""
  local N_A="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  local N_B="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  local G_U="$(git ls-files --other --exclude-standard 2> /dev/null)"
  [ "$N_A" -gt 0 ] && _out="${_out}%{$fg[green]%}+${N_A}"
  [ "$N_B" -gt 0 ] && _out="${_out}%{$fg[green]%}-${N_B}"
  [ "$G_U" != "" ] && _out="${_out}%{$fg_bold[red]%}?"
  git diff --quiet 2> /dev/null || _out="${_out}%{$fg_bold[yellow]%}M"
  git diff --cached --quiet 2>/dev/null || _out="${_out}%{$fg_bold[yellow]%}!"
  [ -n $_out ] && echo "%{$fg[magenta]%}[${_out}%{$fg[magenta]%}]"
}
function _pwd_prpt() {
  vcs_info
  [ -n "$vcs_info_msg_0_" ] \
    && echo -n "${vcs_info_msg_0_/\/. / }$(_git_prpt) " \
    || echo -n "%{$fg[cyan]%}%3~ "
}
function _vpn_prpt() {
  ip a | grep -e "inet.*tun\|inet.*tap" \
    | sed "s/.*inet //g;s/\/[0-9]\{1,2\}.*//g" \
    | tr '\n' '-' \
    | rev \
    | cut -d '-' -f 2- \
    | rev \
    | xargs -I '{}' echo "%{$fg[yellow]%}[{}] " || return 0
}

autoload -Uz compinit colors vcs_info && compinit -d && colors
zstyle ":vcs_info:git:*" formats \
  "%{$fg[magenta]%}%r/%S (%{$fg_bold[yellow]%}%b%{$fg[magenta]%})"
_user="%(!.%{$fg[magenta]%}.%{$fg[yellow]%})%n%{$fg[white]%} in "
_isroot="%(!.%{$fg[magenta]%}>.%{$fg[yellow]%}>)"
_status="%(?.%{$fg[green]%}>>.%{$fg[red]%}>>) "

PROMPT="${_user}\$(_pwd_prpt)\$(_vpn_prpt)${_isroot}${_status}%{$reset_color%}"
RPROMPT="%(?..%{$fg[red]%}[%?])%{$reset_color%}"
