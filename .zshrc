# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pure"
export TERM='xterm-256color'

export DYLD_LIBRARY_PATH='/opt/oracle/instantclient_11_2'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=7

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# I'm considering extracting the aliases I actually use... and leaving the rest.
plugins=(git brew bundler postgres ruby zeus)

source $ZSH/oh-my-zsh.sh

#############################################
### User configuration

export PATH="/usr/local/share/npm/bin":$PATH
export PATH="/usr/texbin":$PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin":$PATH
export PATH="$HOME/.rbenv/bin":$PATH
export PATH="$HOME/.rbenv/shims":$PATH
#export PATH="$HOME/.pyenv/bin":$PATH
#export PATH="$HOME/.pyenv/shims":$PATH
export PATH="$HOME/.goenv/bin":$PATH
#export PATH="$HOME/.goenv/shims":$PATH
export PATH="/usr/local/heroku/bin":$PATH
export PATH="/usr/local/narwhal/bin":$PATH
export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim' # export EDITOR='mvim'
fi

# Preferred key bindings (vi instead of emacs)
bindkey -v
# Kill the lag
export KEYTIMEOUT=1

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


######################################
### ALIASES

# be nice to windows users
alias dir='ls'
alias c='clear'
alias cls='clear'
# personal aliases
alias md='mkdir -p'
alias rd='rmdir'
alias l='ls -la'
alias la='ls -al'
alias ll='ls -l'
alias ls='ls -CFG'
alias lsa='ls -lah'
alias pls='sudo'
alias please='sudo'
alias cmod='sudo'
alias touche='touch'
alias gut='git'
alias bru='brew'

# dev aliases
alias b='bundle'
alias be='bundle exec'
alias z='zeus'
alias zr='zeus rake'
alias zs='zeus server'
alias zc='zeus console'
alias zd='zeus dbconsole'
alias gblame='git blame'
alias wtf='git blame'
alias gg='git add -A .; git commit -m'
alias ggm='git add -A .; git commit'
alias gf='git fetch'
alias rk='bundle exec rake'

# tmux aliases
alias t='tmux'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tm='tmux show-messages'

# db aliases
alias startmysql="mysql.server start"
alias stopmysql="mysql.server stop"

# project aliases
#ereadz_domain='mogulview.com'
#ssh_client='ssh'
#user_name='simon'
#ip_partial='176.9.70'
#alias production="$ssh_client $user_name@mds.$ereadz_domain"
#alias staging="$ssh_client $user_name@staging.$ereadz_domain"
#alias development="$ssh_client $user_name@development.$ereadz_domain"
#alias upgrade="$ssh_client $user_name@$ip_partial.209"

#alias productionip="$ssh_client $user_name@$ip_partial.210"
#alias stagingip="$ssh_client $user_name@$ip_partial.210"
#alias developmentip="$ssh_client $user_name@$ip_partial.209"

# command aggregation aliases
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
# .*rc file changes
alias zrc="vim ~/.zshrc"
alias vrc="vim ~/.vimrc"
alias trc="vim ~/.tmux.conf"


######################################
### Custom Shell Features

# jump to gems directory of current ruby version
gemsdir(){
  RBV="$(rbenv version-name)"
  echo "~/.rbenv/versions/$RBV/lib/ruby/gems/$RBV/gems"
}
alias gems=$(gemsdir)

# create pull request into specified branch (develop if none specified)
function gpr {
  echo Opening pull request for $(current_branch)
  repo=`git remote -v | head -1 | sed "s/git@github.com://" | cut -c8-999 | sed "s/\.git .*//"`
  branch=""
  if [ $1 ]; then
    branch="$1...$(current_branch)"
  else
    branch=$(current_branch)
  fi

  open "https://github.com/$repo/compare/$branch?expand=1"
}

# list pull requests for repo
function gprl {
  repo=`git remote -v | head -1 | sed "s/git@github.com://" | cut -c8-999 | sed "s/\.git .*//"`
  echo Opening list of pull requests for $repo
  open "https://github.com/$repo/pulls"
}

# crude "bundle exec" for node
ne() { $(npm bin)/$*; }

# git emoji

gcma()  { git commit -m ":star2: $*";  }        # add
gcmr()  { git commit -m ":scissors: $*";  }     # remove
gcmc()  { git commit -m ":hammer: $*";  }       # chore
gcmf()  { git commit -m ":wrench: $*";  }       # fix
gcmhf() { git commit -m ":fire: $*";  }         # hotfix
gcmrl() { git commit -m ":rocket: $*";  }       # release
gcmrf() { git commit -m ":nut_and_bolt: $*";  } # refactor
gcmw()  { git commit -m ":hourglass: $*";  }    # wip

# git emoji help
function gcmh {
  echo "gcma :star2:  add"
  echo "gcmr :scissors:  remove"
  echo "gcmc :hammer:  chore"
  echo "gcmf :wrench:  fix"
  echo "gcmhf :fire:  hotfix"
  echo "gcmrl :rocket:  release"
  echo "gcmrf :nut_and_bolt:  refactor"
  echo "gcmw :hourglass:  wip"
}

######################################
### ENVIRONMENT

# rails devise default user for railsapps composer
export ADMIN_NAME="Admin Guy"
export ADMIN_EMAIL="admin@example.com"
export ADMIN_PASSWORD="password123"

# env variables
export NODE_PATH=/usr/local/lib/node
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH="$HOME/.goenv/bin"
export NARWHAL_ENGINE=jsc
export CAPP_BUILD=$HOME/.cappbuild
#export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
export ANDROID_HOME=/usr/local/Cellar/android-sdk/24.0.2

## For MacTeX
eval `/usr/libexec/path_helper -s`

# rbenv and pyenv
eval "$(rbenv init -)"
#eval "$(pyenv init -)"
#eval "$(goenv init -)"
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node_modules
export PATH="$HOME/.ndenv/bin:$PATH"
eval "$(ndenv init -)"
