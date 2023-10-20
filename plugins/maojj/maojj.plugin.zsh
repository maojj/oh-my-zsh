alias gdc="gdca"
alias push="git push -u origin HEAD"
alias pushf="git push --force -u origin HEAD"
alias p="gccc;pushf"
alias sortfolder="du | sort -nr | cut -f2- | xargs du -hs"
alias glsubmodule="git submodule foreach git pull origin master:master"
alias gstl="git stash list"
alias gstap="git stash apply"
alias gccc="git commit --amend --no-edit"
alias ql=quick-look
alias gmnf='git merge --no-ff --log=9999'
alias delremotebranch="git branch -r --merged | egrep -v '(^\*|master|online|test)' | sed 's/origin\//:/'"
alias jq="json_pp"
alias cleanGCDA='find . -name "*.gcda" -print0 | xargs -0 rm'
alias resetMain='git reset --hard origin/main'
alias start='kill3000; make build'
# alias makeWasmOnly='cmake --build cmake-build-debug-emscripten --target wk-wasm-only-for-web'
alias ooo='./scripts/wmk -wd wk-wasm-app-only-for-web-by-brotli'
alias aaa='./scripts/wmk -wd wk-wasm-app-by-brotli'
alias makeTest='cmake --build cmake-build-debug --target wk-util-test wk-render-test wk-editor-render-test wk-document-test wk-handler-test'
alias fixup='gcmsg fixup;push'

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

function wktest() {
  cmake --build build --target wk-util-test wk-resource-test wk-render-element-test wk-render-tree-test wk-render-spatial-index-test wk-render-pass-test wk-render-editor-test wk-editor-render-test wk-document-test wk-handler-test wk-presenter-test wk-integration-test | tee build/compile.out


  find . -name '*.gcda' -delete
  (cd build/wk-integration-test && ./wk-integration-test)
  (cd build/wk-handler/test && ./wk-handler-test)
  (cd build/wk-presenter/test && ./wk-presenter-test)
  (cd build/wk-util/test && ./wk-util-test)
  (cd build/wk-resource/test && ./wk-resource-test)
  (cd build/wk-render/wk-render-element/test && ./wk-render-element-test)
  (cd build/wk-render/wk-render-tree/test && ./wk-render-tree-test)
  (cd build/wk-render/wk-render-spatial-index/test && ./wk-render-spatial-index-test)
  (cd build/wk-render/wk-render-pass/test && ./wk-render-pass-test)
  (cd build/wk-render/wk-render-editor/test && ./wk-render-editor-test)
  (cd build/wk-editor-render/test && ./wk-editor-render-test)
  (cd build/wk-document/test && ./wk-document-test)
}

alias kill3000="killport 3000"
alias dev="devs"
alias devq="devs"
alias devs="kill3000;npm run dev:https"

function delremotebranchfilter() {
  delremotebranch | grep $1 | awk '{print $1}' | xargs git push origin
}

function nb() {(set -e  
  clean_up () {
    ARG=$?
    if [[ $ARG == 0 ]]; then
      exit $ARG
    fi


    if [[ $gitDirty == 1 ]]; then
      git stash pop
    fi

    echo "${logPrefix} exit for some Error!!! check the log above"
    exit $ARG
  } 
  trap clean_up EXIT

  if [ "$#" -ne 1 ]; then
    branchName=`git rev-parse --abbrev-ref HEAD`
  else
    branchName="maojj/wk-$1"
  fi


  logPrefix="\n[new branch]:";

  gitDirty=0;
  if [[ $(git diff --stat) != '' || $(git diff --cached) != '' ]]; then
    echo "${logPrefix} git work space is dirty, git stash it:"
    echo "git stash"
    git stash 
    gitDirty=1;
  fi

  echo "${logPrefix} git checkout main"
  git checkout main

  echo "${logPrefix} git checkout main"
  git pull --rebase

  echo "${logPrefix} delete local branch no in remote:"
  echo "git fetch -p && git branch -vv | awk '/: gone]/{print \$1}' | xargs git branch -D"
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D || true

  echo "${logPrefix} git checkout -b ${branchName}"
  git checkout -b $branchName

  if [[ $gitDirty == 1 ]]; then
    echo "${logPrefix} previous git work space is dirty, now git stash pop it"
    echo "git stash pop"
    git stash pop
  fi

)}


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


function poff() {
        unset http_proxy
        unset https_proxy
        unset ftp_proxy
        unset rsync_proxy
        echo -e "已关闭公司代理"
}

function pon() {
        export no_proxy="localhost,127.0.0.1,local.yuanfudao.biz,.yuanfudao.com,.yuanfudao.biz,.zhenguanyu.com"
        export http_proxy="http://proxy.zhenguanyu.com:8118"
        export https_proxy=$http_proxy
        export ftp_proxy=$http_proxy
        export rsync_proxy=$http_proxy
        export HTTP_PROXY=$http_proxy
        export HTTPS_PROXY=$http_proxy
        export FTP_PROXY=$http_proxy
        export RSYNC_PROXY=$http_proxy
        echo -e "已开启公司代理"
}


