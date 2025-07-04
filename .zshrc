# Enable History
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# Search through command history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

# EDIT COMMAND in $EDITOR
#bindkey -v
#autoload edit-command-line
#zle -N edit-command-line
#bindkey -M vicmd v edit-command-line

# PROMPT
setopt prompt_subst

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/(\1)/p'
}

function pe_gen_prompt() {
    P_COLOR_1=234
    if [ $(id -u) -ne 0 ];  then
        P_COLOR_2=33
    else
        P_COLOR_2=196
    fi
    P_COLOR_3=236
    P_COLOR_4=248
    P_COLOR_TEXT=231
    P_SEP_CHAR=$'\UE0B0'
    PROMPT_TIME="%F{$P_COLOR_TEXT}%K{$P_COLOR_1}[%*]%k%f"
    PROMPT_SEP_1="%F{$P_COLOR_1}%K{$P_COLOR_2}${P_SEP_CHAR}%k%f"
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        P_USER="%n@%M"
    else
        P_USER="%n"
    fi
    PROMPT_USER="%F{$P_COLOR_TEXT}%K{$P_COLOR_2} $P_USER %k%f"
    PROMPT_SEP_2="%F{$P_COLOR_2}%K{$P_COLOR_3}${P_SEP_CHAR}%k%f"
    PROMPT_DIR="%F{$P_COLOR_TEXT}%K{$P_COLOR_3} %~ %k%f"

    git_branch="$(parse_git_branch)"
    if [[ $git_branch == "" ]]; then
        PROMPT_SEP_3="%F{$P_COLOR_3}${P_SEP_CHAR}%f"
        PROMPT_GIT=""
        PROMPT_SEP_4=""
    else
        PROMPT_SEP_3="%F{$P_COLOR_3}%K{$P_COLOR_4}${P_SEP_CHAR}%k%f"
        PROMPT_GIT="%F{$P_COLOR_TEXT}%K{$P_COLOR_4} $git_branch %k%f"
        PROMPT_SEP_4="%F{$P_COLOR_4}${P_SEP_CHAR}%f"
    fi
    
    echo "${PROMPT_TIME}${PROMPT_SEP_1}${PROMPT_USER}${PROMPT_SEP_2}${PROMPT_DIR}${PROMPT_SEP_3}${PROMPT_GIT}${PROMPT_SEP_4}
$ "
}

export PROMPT='$(pe_gen_prompt)'

