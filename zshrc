# ===============================================
# Complete .zshrc Configuration - Arch Linux
# Migrated from macOS setup
# ===============================================

# ===============================================
# PATH Configuration
# ===============================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Mise (if installed)
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

# ===============================================
# ZSH History Configuration
# ===============================================
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# History options
setopt SHARE_HISTORY              # Share history between all sessions
setopt HIST_IGNORE_DUPS          # Don't record duplicate entries
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicates
setopt HIST_REDUCE_BLANKS        # Remove extra whitespace
setopt HIST_IGNORE_SPACE         # Don't save commands starting with space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicates to history file
setopt INC_APPEND_HISTORY        # Write to history immediately
setopt HIST_EXPIRE_DUPS_FIRST    # Remove older duplicates first
setopt HIST_FIND_NO_DUPS         # Don't display duplicates in search

# ===============================================
# ZSH Options
# ===============================================
setopt AUTO_CD                   # cd by typing directory name
setopt CORRECT                   # Command correction
setopt CORRECT_ALL               # Correct all arguments
setopt NO_CASE_GLOB             # Case insensitive globbing
setopt NUMERIC_GLOB_SORT        # Sort numerically when possible
setopt EXTENDED_GLOB            # Extended globbing

# Ignore patterns for correction
CORRECT_IGNORE='(_*|*/_*)'

# ===============================================
# Completion System
# ===============================================
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # Colors
zstyle ':completion:*' menu select                       # Menu selection

# ===============================================
# Custom History Navigation (cursor at end)
# ===============================================
up-history-end-of-line() {
    zle up-line-or-history
    zle end-of-line
}

down-history-end-of-line() {
    zle down-line-or-history
    zle end-of-line
}

# Register the functions as ZLE widgets
zle -N up-history-end-of-line
zle -N down-history-end-of-line

# Bind to arrow keys
bindkey '^[[A' up-history-end-of-line    # Up arrow
bindkey '^[[B' down-history-end-of-line  # Down arrow

# ===============================================
# FZF Configuration
# ===============================================

# Load FZF key bindings and completion
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
fi

if [ -f /usr/share/fzf/completion.zsh ]; then
    source /usr/share/fzf/completion.zsh
fi

# FZF Default Options - Catppuccin Mocha Theme
export FZF_DEFAULT_OPTS="
  --height=80%
  --layout=reverse-list
  --border=bold
  --border-label-pos=3
  --margin=1,2
  --padding=1,2
  --info=inline-right
  --prompt='❯ '
  --pointer='▶'
  --marker='✅'
  --separator='─'
  --scrollbar='▌▐'
  --ellipsis='…'
  --tabstop=2
  --bind='alt-k:up,alt-j:down'
  --bind='ctrl-u:half-page-up'
  --bind='ctrl-d:half-page-down'
  --bind='ctrl-f:page-down'
  --bind='ctrl-b:page-up'
  --bind='ctrl-g:top'
  --bind='ctrl-h:backward-char'
  --bind='ctrl-l:forward-char'
  --bind='alt-left:backward-word,alt-right:forward-word'
  --bind='ctrl-w:backward-kill-word'
  --bind='alt-bs:backward-kill-word'
  --bind='ctrl-y:yank'
  --bind='ctrl-/:change-preview-window(down,border-top|hidden|)'
  --bind='alt-/:change-preview-window(right,border-left|hidden|)'
  --bind='alt-up:preview-page-up,alt-down:preview-page-down'
  --bind='ctrl-s:toggle-sort'
  --bind='ctrl-t:toggle-all'
  --bind='alt-enter:print-query'
  --bind='ctrl-alt-l:clear-query'
  --preview-window='right:50%:wrap:border-left'
  --color='fg:#CDD6F4,bg:#1E1E2E,hl:#F38BA8'
  --color='fg+:#CDD6F4,bg+:#313244,hl+:#F9E2AF'
  --color='info:#CBA6F7,prompt:#CBA6F7,pointer:#F9E2AF'
  --color='marker:#A6E3A1,spinner:#F9E2AF,header:#94E2D5'
  --color='gutter:#1E1E2E,selected-bg:#313244,selected-fg:#CDD6F4'
  --color='disabled:#6C7086,preview-bg:#181825,preview-fg:#CDD6F4'
  --color='border:#89B4FA,preview-border:#89B4FA,query:#94E2D5:regular'
"

# FZF File Preview (Ctrl+T)
export FZF_CTRL_T_OPTS="
  --border-label=' 📁 Files '
  --preview='
    if [[ -f {} ]]; then
      file_type=\$(file --mime-type -b {})
      case \$file_type in
        text/*|application/json|application/xml|application/javascript)
          if command -v bat > /dev/null 2>&1; then
            bat --color=always --style=header,grid --line-range :300 {}
          elif command -v highlight > /dev/null 2>&1; then
            highlight -O ansi --force {}
          else
            cat {} | head -300
          fi
          ;;
        image/*)
          if command -v chafa > /dev/null 2>&1; then
            chafa --fill=block --symbols=block -c 256 -s 80x24 {}
          elif command -v catimg > /dev/null 2>&1; then
            catimg -w 80 {}
          else
            echo \"🖼️  Image file: {}\"
            file {}
          fi
          ;;
        application/pdf)
          if command -v pdftotext > /dev/null 2>&1; then
            pdftotext {} - | head -100
          else
            echo \"📄 PDF file: {}\"
            file {}
          fi
          ;;
        *)
          echo \"📎 Binary file: {}\"
          file {}
          ls -la {}
          ;;
      esac
    elif [[ -d {} ]]; then
      if command -v eza > /dev/null 2>&1; then
        eza --tree --level=2 --color=always --icons {}
      elif command -v tree > /dev/null 2>&1; then
        tree -C -L 2 {}
      else
        ls -la --color=always {}
      fi
    else
      echo \"Unknown file type: {}\"
      file {}
    fi
  '
  --bind='enter:become(echo {})'
  --bind='ctrl-e:execute(echo {+} | xargs -o \$EDITOR)'
  --bind='ctrl-o:execute(xdg-open {+})'
  --bind='alt-e:execute(echo {+} | xargs -I {} sh -c \"cd \$(dirname {}) && \$EDITOR \$(basename {})\")'
  --header='ENTER: select, CTRL-E: edit, CTRL-O: open, CTRL-/: toggle preview'
"

# FZF History (Ctrl+R)
export FZF_CTRL_R_OPTS="
  --border-label=' 📜 History '
  --preview='echo {}'
  --preview-window='right:50%:wrap:border-left'
  --bind='ctrl-p:change-preview-window(right:50%:wrap:border-left|hidden|)'
  --bind='alt-/:change-preview-window(down:50%:wrap:border-top|right:50%:wrap:border-left|hidden|)'
  --bind='alt-up:preview-page-up'
  --bind='alt-down:preview-page-down'
  --bind='shift-up:preview-up'
  --bind='shift-down:preview-down'
  --bind='ctrl-y:execute-silent(echo {} | sed \"s/^[ ]*[0-9]*[ ]*//\" | wl-copy)'
  --bind='ctrl-a:select-all'
  --bind='ctrl-d:deselect-all'
  --bind='ctrl-t:toggle-all'
  --bind='tab:toggle+down'
  --bind='shift-tab:toggle+up'
  --bind='ctrl-g:top'
  --bind='end:last'
  --bind='ctrl-/:toggle-sort'
  --bind='ctrl-s:toggle-sort'
  --bind='alt-c:clear-query'
  --bind='f1:change-query(cat )'
  --bind='f2:change-query(vim )'
  --bind='f3:change-query(git )'
  --bind='f4:change-query(docker )'
  --bind='f5:change-query(ls )'
  --bind='f6:change-query(grep )'
  --bind='f7:change-query(find )'
  --bind='f8:change-query(cd )'
  --bind='esc:clear-query'
  --bind='?:toggle-preview'
  --header='⚡ ENTER: execute | CTRL-Y: copy | F1-F8: filters'
  --query=''
  --prompt='hist❯ '
"

# FZF Directory Navigation (Alt+C)
export FZF_ALT_C_OPTS="
  --border-label=' 📂 Directories '
  --preview='
    if command -v eza > /dev/null 2>&1; then
      eza --tree --level=2 --color=always --icons {}
    elif command -v tree > /dev/null 2>&1; then
      tree -C -L 2 {}
    else
      ls -la --color=always {}
    fi
  '
  --bind='enter:become(echo {})'
  --header='ENTER: cd to directory'
"

export FZF_COMPLETION_OPTS="
  --border-label=' 🔧 Completion '
  --info=inline
  --layout=reverse
  --border=rounded
"

export FZF_TMUX_OPTS="-p80%,60%"

# ===============================================
# Custom FZF Functions
# ===============================================

# Enhanced directory finder with cd
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Git branch switcher
fgb() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Process killer
fkill() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Git diff with FZF
fd() {
  git diff $@ --name-only | fzf -m --ansi --preview="git diff $@ --color=always -- {-1}"
}

# ===============================================
# ZSH Plugins (Arch Linux paths)
# ===============================================

# Syntax highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Auto-suggestions
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ===============================================
# Modern CLI Tool Aliases
# ===============================================

# bat - better cat with syntax highlighting
export BAT_THEME="Catppuccin Mocha"
alias cat='bat --paging=never'
alias bcat='bat'
alias bathelp='bat --list-themes'

# eza - better ls
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first --git'
alias la='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons'
alias l='eza -1 --icons'

# grep with colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'

# ===============================================
# Git Aliases
# ===============================================
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# ===============================================
# Music Download Aliases (yt-dlp)
# ===============================================
alias dl-music='yt-dlp'
alias dl-song='yt-dlp --no-playlist'
alias dl-playlist='yt-dlp --yes-playlist'

# Music management functions with MPD integration
dlm() {
  # Download music and auto-rescan MPD
  yt-dlp "$@" && mpc rescan --wait && echo "✅ Music added! Updated MPD library."
}

dls() {
  # Download single song (no playlist)
  yt-dlp --no-playlist "$@" && mpc rescan --wait && echo "✅ Song added!"
}

dlp() {
  # Download playlist
  yt-dlp --yes-playlist "$@" && mpc rescan --wait && echo "✅ Playlist added!"
}

# ===============================================
# Additional Aliases
# ===============================================

# Editor
alias vim='nvim'
alias vi='nvim'

# Clipboard (Wayland)
alias pbcopy='wl-copy'
alias pbpaste='wl-paste'

# ===============================================
# Environment Variables
# ===============================================
export EDITOR="nvim"
export VISUAL="nvim"
export COLUMNS=120

# ===============================================
# Zoxide (Smart cd)
# ===============================================
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# ===============================================
# MPD Auto-Start
# ===============================================
if command -v mpd &> /dev/null && ! pgrep -x mpd > /dev/null 2>&1; then
  mpd ~/.config/mpd/mpd.conf 2>/dev/null
fi

# ===============================================
# Prompt (Starship or Simple)
# ===============================================
# If you want to use starship prompt:
# if command -v starship &> /dev/null; then
#     eval "$(starship init zsh)"
# fi

# Simple colored prompt (fallback)
if ! command -v starship &> /dev/null; then
    autoload -Uz colors && colors
    PROMPT='%F{blue}%~%f %F{green}❯%f '
fi

# ===============================================
# Welcome Message
# ===============================================
echo "🚀 ZSH loaded - Arch Linux edition"
if command -v fastfetch &> /dev/null; then
    fastfetch
fi
