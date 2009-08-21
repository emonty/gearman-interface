# pre_hook.sh - Commands that we run before we run the autotools

if test -d ".bzr" ; then
  echo "Grabbing changelog and version information from bzr"
  bzr log --short > ChangeLog || touch ChangeLog
else
  touch ChangeLog
fi
