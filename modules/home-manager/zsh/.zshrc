# Source bash profile if it exists
[[ -e ~/.bash_profile ]] && emulate sh -c 'source ~/.bash_profile'

# Start shell prompt
eval "$(oh-my-posh init zsh --config ~/theme.omp.json)"
