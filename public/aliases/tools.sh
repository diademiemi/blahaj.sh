# Generate password hash
alias genpasswd="python3 -c 'import crypt,getpass; print(crypt.crypt(getpass.getpass(), crypt.mksalt(crypt.METHOD_SHA512)))'"

# Clean podman environment
alias podman-clean="podman stop -a && podman rm -a && yes | podman volume prune"

# ProtonVPN
alias pvpn="protonvpn-cli"

# yt-dlp
alias yt-dlp-flac="yt-dlp --audio-quality 0 --extract-audio --audio-format flac --embed-subs --add-metadata --embed-thumbnail"


## Convenience

# Create a directory and enter it
# Usage:
# mkcd dirname
function  mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}

# Resursively run sed on files
# Usage:
# rsed 's/foo/bar/g' dir1 dir2 file3
function  rsed ()
{
  find ${@:2} -type f -exec sed -i "$1" {} +
}

# Change file extension in bulk
# Usage:
# chext oldext newext file1 file2 file3
function  chext ()
{
  for f in ${@:3}; do
    if [[ $f == *.${1} ]]; then mv -- "$f" "${f%.${1}}.${2}"; fi
  done
}

# Run a command on (multiple) hosts
# Usage:
# sshb "ls -lah" host1 host2
function  sshb ()
{
 for host in ${@:2}; do
    printf "\033[0;34mRunning on \033[0;31m${host}\033[0m\n";
    ssh -q -t $host "$1";
  done
}

pre-commit-recursive ()
{
  action=$1
  dir=$2
  if [[ -z "$action" ]]; then
    echo "No action provided"
    echo "Example: pre-commit-recursive install"
    return 1
  fi

  if [[ -z "$dir" ]]; then
    dir="."
  fi

  find $dir -name ".pre-commit-config.yaml" -exec printf "\nRunning pre-commit $action at" \; -exec dirname {} \; -execdir pre-commit $action \;
}
