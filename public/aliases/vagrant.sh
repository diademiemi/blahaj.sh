# Replace SSH config file using input
# If ~/.ssh/config.base exists, it will used as a base
function sshc()
{
  input=$(cat)
  echo $input > ~/.ssh/vagrant
}

# Vagrant
alias vag="vagrant"
alias vup="vagrant up"
alias vde="vagrant destroy -f"
alias vha="vagrant halt"
alias vssh="vagrant ssh-config" # Get SSH config
alias vsshc="vssh | sshc" # Get SSH config and use it to replace ~/.ssh/config
alias vredo="vagrant destroy -f; vagrant up; vagrant ssh-config | sshc" # Redo environment
