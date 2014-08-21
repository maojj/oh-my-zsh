# To use: add a .gerrit-url file in the base of your project
#         You can also set GERRIT_URL in your .zshrc or put .gerrit-url in your home directory
#         .gerrit-url in the current directory takes precedence
#
# Setup: cd to/my/project
#        echo "http://gerrit.company.com" >> .gerrit-url
# Usage: gerrit                 # opens default webpage
#        gerrit [review-ID]     # opens an existing review
open_gerrit_issue () {
  local open_cmd
  if [[ $(uname -s) == 'Darwin' ]]; then
    open_cmd='open'
  else
    open_cmd='xdg-open'
  fi

  if [ -f .gerrit-url ]; then
    gerrit_url=$(cat .gerrit-url)
  elif [ -f ~/.gerrit-url ]; then
    gerrit_url=$(cat ~/.gerrit-url)
  elif [[ "x$GERRIT_URL" != "x" ]]; then
    gerrit_url=$GERRIT_URL
  else
    echo "GERRIT url is not specified anywhere."
    return 0
  fi

  if [ -z "$1" ]; then
    echo "Opening default webpage"
    $open_cmd "$gerrit_url"
  else
    echo "Opening issue #$1"
    echo "${gerrit_url}"
    $open_cmd  "$gerrit_url/$1"
  fi
}

alias gerrit='open_gerrit_issue'
