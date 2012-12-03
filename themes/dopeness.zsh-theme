BAT_CHARGE="$HOME/bin/batcharge.py"

MAIN_PROMPT='$FG[032]λ ${PWD/#$HOME/~}%{$reset_color%} $FG[036]$(git_prompt_info)%{$reset_color%}
$FG[032]→%{$reset_color%} '

USER_PROMPT='%n@%m'

# right prompt with battery indicator
RPROMPT_BAT='%(?..%{$fg_bold[red]%}(%?%)) $(battery_charge) %{$reset_color%}$FG[237]%D{%F} %*%{$reset_color%}'
# right prompt sans batter indicator
RPROMPT_NOBAT='%(?..%{$fg_bold[red]%}(%?%)) %{$reset_color%}$FG[237]%D{%F} %*%{$reset_color%}'

if [[ `uname` = Darwin ]]; then
	# hide user@host when running on darwin/local
	PROMPT=$MAIN_PROMPT
	if [[ -x $BAT_CHARGE ]]; then
		# show a battery charge indicator when on os x when the battery script can be found
		RPROMPT=$RPROMPT_BAT
	else
		RPROMPT=$RPROMPT_NOBAT
	fi
else 
	PROMPT="$USER_HOME $MAIN_PROMPT"
	RPROMPT=$RPROMPT_NOBAT
fi

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=" *"
ZSH_THEME_GIT_PROMPT_SUFFIX=")"

function battery_charge {
	echo `$BAT_CHARGE` 2>/dev/null
}
