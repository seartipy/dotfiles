local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'
local  node_version='%{$fg[red]%}‹$(nvm_prompt_info)›%{$reset_color%}'

PROMPT="╭─${current_dir} ${node_version} ${git_branch}
╰─%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
