svndiff()
{
  svn diff "${@}" | colordiff | less -R
}

diffdiff()
{
  interdiff $1 $2  | colordiff | less -R
}

export WORKON_HOME=$HOME/code
