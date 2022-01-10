#PROMPT='%{$fg_bold[magenta]%}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} %# %{$reset_color%}'
PROMPT='%(!.%{$fg[red]%}.%{$fg[cyan]%})%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} %# %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} x%{$reset_color%}%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
