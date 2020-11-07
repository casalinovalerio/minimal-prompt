_git_ahead="${MINPROMPT_GIT_AHEAD:-"+"}"
_git_behind="${MINPROMPT_GIT_BEHIND:-"-"}"
_git_untracked="${MINPROMPT_GIT_UNTRACKED:-"?"}"
_git_modified="${MINPROMPT_GIT_MODIFIED:-"M"}"
_git_cached="${MINPROMPT_GIT_CACHED:-"!"}"
_git_prefix="${MINPROMPT_GIT_PREFIX:-"%{$fg[red]%}["}"
_git_suffix="${MINPROMPT_GIT_SUFFIX:-"%{$fg[red]%}]"}"
_gitb_symbol="%{${MINPROMPT_GIT_BRANCH_SYMBOL:-""}%1G%}"
_char_symbol="%{${MINPROMPT_CHAR_SYMBOL:-""}%1G%}"

_creset="%{$reset_color%}"

function _git_status_prompt() {
  local _out=""
  local N_A="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  local N_B="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  local G_U="$(git ls-files --other --exclude-standard 2> /dev/null)"
  [ "$N_A" -gt 0 ] && _out="${_out}${_git_ahead}${N_A}"
  [ "$N_B" -gt 0 ] && _out="${_out}${_git_behind}${N_B}"
  [ "$G_U" != "" ] && _out="${_out}${_git_untracked}"
  git diff --quiet 2>/dev/null || _out="${_out}${_git_modified}"
  git diff --cached --quiet 2>/dev/null || _out="${_out}${_git_cached}"
  [ "$_out" != "" ] && echo "${_git_prefix}${_out}${_git_suffix} "
}
function _pwd_prompt() {
  vcs_info
  [ -n "$vcs_info_msg_0_" ] \
    && echo -n "${vcs_info_msg_0_/\/./}$(_git_status_prompt)" \
    || echo -n "%{$fg[cyan]%}%3~ "
}
function _vpn_prompt() {
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
  "%{$fg[cyan]%}%r/%S${_creset} on %{$fg_bold[magenta]%}${_gitb_symbol} %b "
_whoami="%(!.%{$fg[red]%}.%{$fg[yellow]%})%n${_creset} in "
_status="%(?.%{$fg[green]%}.%{$fg[red]%})%B${_char_symbol}%b "

PROMPT="${_whoami}\$(_pwd_prompt)\$(_vpn_prompt)${_status}${_creset}"
RPROMPT="%(?..%{$fg[red]%}[%?])${_creset}"
