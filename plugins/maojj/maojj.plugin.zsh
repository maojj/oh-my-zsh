alias gdc="gdca"
alias push="git push -u origin HEAD"
alias p="maojjpush"
alias sortfolder="du | sort -nr | cut -f2- | xargs du -hs"
alias glsubmodule="git submodule foreach git pull origin master:master"
alias gstl="git stash list"
alias gstap="git stash apply"
alias gccc="git commit --amend --no-edit"
alias ql=quick-look
alias gmnf='git merge --no-ff --log=9999'
alias delremotebranch="git branch -r --merged | egrep -v '(^\*|master|online|test)' | sed 's/origin\//:/'"
alias jq="jsonpp"
alias cleanGCDA='find . -name "*.gcda" -print0 | xargs -0 rm'
alias resetMain='git reset --hard origin/main'

function deleteLocalBranchNoInRemote() {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

function killport() {
  pid=`lsof -i tcp:$1 | grep 'LISTEN' | awk '{print $2}'`
  if [[ $pid -gt 0 ]]; then 
    kill -9 $pid
  fi
}

alias kill3000="killport 3000"
alias dev="devs"
alias devq="devs"
alias devs="kill3000;npm run dev:https"

function delremotebranchfilter() {
  delremotebranch | grep $1 | awk '{print $1}' | xargs git push origin
}

# fenbi 跳板机器
function pp { 
  if [ -f ${OATH_KEY_HOME}/$1 ]
    then
      CODE=$(oathtool --totp -b -d 6 `cat ${OATH_KEY_HOME}/$1`)
      if [ `uname` = 'Darwin' ]
        then 
          echo -n $CODE | pbcopy # Comment out if you don't want the
                                 # OTP to be automatically copied to
                                 # the clipboard on Mac OS X
      fi
      echo "$CODE"
  else
    echo "No key specified, or key not found."
    echo "Available keys:"
    ls $OATH_KEY_HOME
  fi
}
alias ff="pp fenbi" # 输出六位验证码并复制到剪贴板，ff 是 fenbi key 的意思
alias kk="ff && ssh -t $LDAP_NAME@access1" # 打印验证码的同时连 ssh，kk 是 keep connection 的意思
alias ss="kk ssh" # 快速 ssh 直连机房主机

alias lastkey="pp lk"

alias sss="source ~/.zshrc"

alias timestamp=$(date +%s)