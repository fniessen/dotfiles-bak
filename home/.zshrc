## .zshrc --- Z Shell configuration file (for interactive shells)

# Copyright (C) 2009-2019 Fabrice Niessen

# Author: Fabrice Niessen <(concat "fniessen" at-sign "pirilampo.org")>
# Keywords: zsh, dotfile, config

#* Code:

# Don't inherit the value of PS1 from the previous shell (Zsh from Bash).
PS1=$'%{\e]0;%d\a%}\n%F{green}%n@%m %F{yellow}%d%f\n%# '

# # For Bash on Ubuntu on Windows.
# export BROWSER='/mnt/c/Windows/explorer.exe' # does not work.
export BROWSER='/mnt/c/Program Files (x86)/Mozilla Firefox/firefox.exe'

FILE="$HOME/.dotfiles/plugins/mintty-colors-solarized/mintty-solarized-dark.sh" && test -f "$FILE" && . "$FILE"

# XXX Check for MinTTY
if [ -d /cygdrive/c/ ]; then
    echo -ne '\e]4;8;#404040\a'     # bold blk
    echo -ne '\e]4;9;#FF4040\a'     # bold red
    echo -ne '\e]4;10;#40FF40\a'    # bold grn
    echo -ne '\e]4;11;#FFFF40\a'    # bold yel
    echo -ne '\e]4;12;#6060FF\a'    # bold blu
    echo -ne '\e]4;13;#FF40FF\a'    # bold mag
    echo -ne '\e]4;14;#40FFFF\a'    # bold cyn
    echo -ne '\e]4;15;#FFFFFF\a'    # bold wht
fi

if [ -r "$HOME/.dotfiles/plugins/oh-my-zsh" ]; then
    ZSH="$HOME/.dotfiles/plugins/oh-my-zsh"
    # ${ZSH_CUSTOM:-~/.dotfiles/plugins/oh-my-zsh/custom}
    ZSH_CUSTOM="$ZSH/custom"

    HIST_STAMPS="yyyy-mm-dd"            # See command `history'.

    COMPLETION_WAITING_DOTS="true"
fi

if [ -r "$ZSH" ]; then
    prompt_svn() {
        local rev branch
        if in_svn; then
            rev=$(svn_get_rev_nr)
            branch=$(svn_get_branch_name)
            if [[ $(svn_dirty_choose_pwd 1 0) -eq 1 ]]; then
                prompt_segment yellow black
                echo -n "$rev@$branch"
                echo -n " ±"
            else
                prompt_segment green black
                echo -n "$rev@$branch"
            fi
        fi
    }
fi

if [ -r "$HOME/.dotfiles/plugins/oh-my-zsh" ]; then
    ZSH_THEME="powerlevel9k/powerlevel9k"

    # Single-line prompt.
    POWERLEVEL9K_PROMPT_ON_NEWLINE=false
    POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

    POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
    POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=''

    # Customise the Powerlevel9k prompts.
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time background_jobs)

    POWERLEVEL9K_STATUS_VERBOSE=false
    POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=10
    POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
fi

if [ -r "$HOME/.dotfiles/plugins/oh-my-zsh" ]; then

    plugins=(
        colored-man-pages
        extract
        # git                           # Provide many aliases and a few useful functions.
        history
        history-substring-search
        svn
        zshmarks
    )
fi

if [ -r "$HOME/.dotfiles/plugins/oh-my-zsh" ]; then
    # Fix Colorize man pages (with `less` pager) not working in Cygwin MinTTY
    export MANROFFOPT="-c"
    # in your shell rc file. This has the same effect as
    # export GROFF_NO_SGR=1
    # but only affects man. I'm not sure if groff is used for anything else
    # besides man pages, but this seems safer to prevent unintended side
    # effects.
fi

if [ -r "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    plugins+=(zsh-syntax-highlighting)
fi

if [ -r "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    plugins+=(zsh-autosuggestions)
fi

if [ -r "$HOME/.dotfiles/plugins/oh-my-zsh" ]; then
    . "$ZSH"/oh-my-zsh.sh
fi

if [ -r "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
fi

# History.
HISTSIZE=1000
SAVEHIST=2000

# Append new history lines instead of overwriting (important for multiple
# parallel Zsh sessions!).
setopt appendhistory

# Don't save command more than once when occuring more often.
setopt HIST_IGNORE_DUPS

# Use the same history file for all sessions.
setopt SHARE_HISTORY

# Change directory given just path.
setopt autocd

# Beep when there's an error with the command text you're typing in (e.g. if you
# hit tab and there are no matching files) -- not as a result of normal commands
# returning errors.
setopt beep

# Use additional pattern matching features.
setopt extendedglob

# Unmatched patterns cause an error.
setopt nomatch

# Immediately report changes in background job status.
setopt notify

# Behave like Emacs when editing.
bindkey -e

# Mappings for `Ctrl-up/down' for matching commands from the history.
bindkey ';5A' history-search-backward
bindkey ';5B' history-search-forward

# Mappings for `Ctrl-left/right' for word moving.
bindkey ';5C' forward-word
bindkey ';5D' backward-word

# Make Zsh beep like Bash when backspacing on an empty command line.
backward-delete-char-beep() {
    if (( CURSOR == 0 )); then
        zle beep
    fi
    zle backward-delete-char
}
zle -N backward-delete-char-beep
bindkey "^?" backward-delete-char-beep

# zstyle :compinstall filename '/cygdrive/d/Users/fni/.zshrc'

# Load general completion.
autoload -Uz compinit
# compinit                                # Security check (insecure directories)!

# Display a list of completions when you give an ambiguous choice (like Bash).
setopt autolist

BEL=$(tput bel)
PROMPT+='%(?::$BEL)'
# Does not work on Bash on Ubuntu on Windows.

echo_blank() {
    echo
}

# preexec_functions+=echo_blank
precmd_functions+=echo_blank

[ "$TERM" = "dumb" ] && PROMPT="> "

[ "$TERM" = "dumb" ] && RPROMPT=""

# Command line head / tail shortcuts
alias -g H='| head' ###
alias -g T='| tail' ###
alias -g G='| grep -E' ######
alias -g L="| less" #######
alias -g M="| less"
alias -g CA="| cat -A"
alias -g 21="2>&1"
alias -g NUL='> /dev/null 2>&1'

alias -g W='| wc -l' ####
alias -g C='| wc -l'
alias -g S='| sort' ###
alias -g F=' | fmt -' ##

alias -g A='| awk'
alias -g A1="| awk '{print \$1}'"
alias -g A2="| awk '{print \$2}'"
alias -g A3="| awk '{print \$3}'"
alias -g A4="| awk '{print \$4}'"
alias -g A5="| awk '{print \$5}'"
alias -g A6="| awk '{print \$6}'"
alias -g A7="| awk '{print \$7}'"
alias -g A8="| awk '{print \$8}'"
alias -g A9="| awk '{print \$9}'"
alias -g ,1="| awk -F, '{print \$1}'"
alias -g ,2="| awk -F, '{print \$2}'"
alias -g ,3="| awk -F, '{print \$3}'"
alias -g ,4="| awk -F, '{print \$4}'"
alias -g ,5="| awk -F, '{print \$5}'"
alias -g ,6="| awk -F, '{print \$6}'"
alias -g ,7="| awk -F, '{print \$7}'"
alias -g ,8="| awk -F, '{print \$8}'"
alias -g ,9="| awk -F, '{print \$9}'"
alias -g :1="| awk -F: '{print \$1}'"
alias -g :2="| awk -F: '{print \$2}'"
alias -g :3="| awk -F: '{print \$3}'"
alias -g :4="| awk -F: '{print \$4}'"
alias -g :5="| awk -F: '{print \$5}'"
alias -g :6="| awk -F: '{print \$6}'"
alias -g :7="| awk -F: '{print \$7}'"
alias -g :8="| awk -F: '{print \$8}'"
alias -g :9="| awk -F: '{print \$9}'"
alias -g T1="| awk -F $'\t' '{print \$1}'"
alias -g T2="| awk -F $'\t' '{print \$2}'"
alias -g T3="| awk -F $'\t' '{print \$3}'"
alias -g T4="| awk -F $'\t' '{print \$4}'"
alias -g T5="| awk -F $'\t' '{print \$5}'"
alias -g T6="| awk -F $'\t' '{print \$6}'"
alias -g T7="| awk -F $'\t' '{print \$7}'"
alias -g T8="| awk -F $'\t' '{print \$8}'"
alias -g T9="| awk -F $'\t' '{print \$9}'"

alias -g ND='$(ls -d *(/om[1]))'        # Newest directory.
alias -g NF='$(ls *(.om[1]))'           # Newest file.

alias -- cdwd='cd $(pwd)'
alias -- cwd='echo $cwd'

alias -g GLWEEK=' --since=1.week.ago'
alias -g GLMONTH=' --since=1.month.ago'
alias -g GLYEAR=' --since=1.year.ago'

# When entering a directory, list the contents.
cd() { builtin cd "$@" && ls; }

export LEDGER=ledger
export LEDGER_FILE=/Users/fni/Personal/Business/Accounting/LEDGER.dat

# hledger print [REGEXP]... - Show entries in Ledger format.
    #! `hledger' is better than `ledger' in the sense that it does output
    #! 2 decimals whatever the figure, and that it does not output trailing
    #! spaces. There is no other difference (not even in indentation).

# Other problem with ledger: reports onto 81 columns when using other DATEFMT...

alias -g LG="\$LEDGER -f \$LEDGER_FILE"
alias -g DATEFMT='-y %Y/%m/%d'  # for output
alias -g DAILY='--period "daily"'
alias -g DLM='--display "d>=[last month]"'  # display of last month
alias -g CLM='-p "last month"'  # computed total of last month
alias -g D1='--display "l<=1" --depth 1'
alias -g D2='--display "l<=2" --depth 2'
alias -g BALANCE_SHEET='^Assets ^Liabilities'
alias -g PROFIT_LOSS='^Expenses ^Income'

alias lastmonth='LG reg TLM'

# Ledger -f FILE [OPTIONS] [COMMAND [PATTERNS]]
# Ledger using `ledger', `hledger' or `beancount' (see `$LEDGER')
Ledger() {
    if [ $# -lt 1 ]; then
        cat << EOF > /dev/stderr
Usage: $(basename "$0") -f FILE [OPTIONS] [COMMAND [PATTERNS]]
    or $(basename "$0") FILE   (if LEDGER=beancount)
EOF
    fi

    case "$LEDGER" in
        "beancount" )
            ;;
        * )   # default option
            shift;  # for the useless (but expected) `-f'
            ;;
    esac
    local LEDGER_M4_FILE=$1; shift;

    local LEDGER_FILE=sample-ledger.dat;
    case "$LEDGER" in
        "beancount" )
            m4 -D LEDGER=beancount "$LEDGER_M4_FILE" \
                | sed -e 's/\(.*\)(\(.*\)) \(.*\)/\1\3 | \2/g' > "$LEDGER_FILE"
            bean-web "$LEDGER_FILE" $@   # beancount Web interface
            ;;
        * )   # default option
            m4 "$LEDGER_M4_FILE" \
               | sed -e 's/^@/;@/' > "$LEDGER_FILE"
            "$LEDGER" -f "$LEDGER_FILE" $@
            ;;
    esac
    rm "$LEDGER_FILE"
}

# Case-insensitive completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

compdef '_files -g "*"' start

# Coloring stderr.
STDERRRED=$'\e[1;31m'
zmodload zsh/system
color_err() {
    # Sysread & syswrite are part of `zsh/system'.
    emulate -LR zsh
    while sysread; do
        syswrite -o 2 "$STDERRRED$REPLY$terminfo[sgr0]"
    done
}

exec 2> >( color_err )

# Source common settings.
. "$HOME"/.shellrc                      # Error displayed if not found.

# Enable overriding.
if [ -f "$HOME"/.zshrc_local ]; then
    . "$HOME"/.zshrc_local
fi

#* Local Variables

# This is for the sake of Emacs.
# Local Variables:
# mode: sh
# mode: outline-minor
# End:

## .zshrc ends here
