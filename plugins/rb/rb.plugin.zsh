# To use: add a .jira-url file in the base of your project
#         You can also set JIRA_URL in your .zshrc or put .jira-url in your home directory
#         .jira-url in the current directory takes precedence
#
# If you use Rapid Board, set:
#JIRA_RAPID_BOARD="yes"
# in you .zshrc
#
# Setup: cd to/my/project
#        echo "https://name.jira.com" >> .jira-url
# Usage: jira           # opens a new issue
#        jira ABC-123   # Opens an existing issue
open_rb_issue () {
  if [ -f .rb-url ]; then
    rb_url=$(cat .rb-url)
  elif [ -f ~/.rb-url ]; then
    rb_url=$(cat ~/.rb-url)
  elif [[ "x$RB_URL" != "x" ]]; then
    rb_url=$RB_URL
  else
    echo "reviewboard url is not specified anywhere."
    return 0
  fi

  if [ -z "$1" ]; then
    echo "input rb number"
  else
    echo "Opening issue #$1"
    `open $rb_url/r/$1/diff/`
  fi
}

alias rb='open_rb_issue'
