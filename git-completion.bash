_mx_completion()
{
  local cur
  cur="${COMP_WORDS[COMP_CWORD]}"

  COMPREPLY=( $(compgen -W "$(ls $PROJECTS)" -- $cur) )
  return 0
}

if [ -d $PROJECTS ]; then
  complete -o bashdefault -o default -F _mx_completion mx
fi
