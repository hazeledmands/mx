_mx_completion()
{
  COMPREPLY=( $(compgen -f "$PROJECTS/${COMP_WORDS[$COMP_CWORD]}")  )
  return 0
}

if [ -d $PROJECTS ]; then
  complete -o bashdefault -o default -F _mx_completion mx
fi
