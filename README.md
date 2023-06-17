# blahaj.sh

This is my personal site, since I got it as a `.sh` TLD i thought it would be fun to make the website serve an interactive shell script.  

As a result, the website is a shell script that can be run locally or remotely. The entrypoint is `blahaj.sh` which is a shell script that will guide you through the sites features.  

The main usage for this site is to include my aliases and functions. You could see this repository as a dotfiles repository.  

## Usage
```bash
$SHELL <(wget -qO- blahaj.sh)
```

This will run the script in-memory. It will present you with a menu of options.  

```
Available Options:

1) Shell aliases/functions

2) Bookmarks

```

Enter "1" to find out more about the shell aliases and functions. It will prompt about which you want to include. This is all temporary, you can clone the repository and include the files directly to make it permanent.  