printf "\n\nAvailable Aliases/Functions:\n\n"
printf "1) Tools:\n\tSimple aliases: pvpn\n\tTools:\n\t- genpasswd: Generate a password hash\n\t- podman-clean: Remove all podman resources\n\t- yt-dlp-flac: Download a link as FLAC\n\t- mkcd: Create a directory and enter it\n\t- rsed: Recursively execute sed\n\t- chext: Change file extension on files\n\t- sshb: Bulk execute SSH command\n\t- pre-commit-recursive: Run pre-commit action on all found repos\n\n"
printf "2) Vagrant:\n\tSimple aliases: vag, vup, vde, vha, vssh\n\tTools:\n\t- vsshc Add Vagrant SSH config to ~/.ssh/vagrant\n\t- vredo: Redoes entire environment\n\n"
printf "3) Kubectl:\n\tSimple aliases: kg<,kg,kgall,kd,kl\n\tTools:\n\t- kns: Set default namespace\n\t- ksec: Fuzzy find a secret and decode it\n\t- kx: Fuzzy find a pod and exec into it\n\t- kfw: Fuzzy find a service or pod and forward a port\n\n"
printf "4) KDE:\n\tTools:\n\t- splitkonsole: Split Konsole automatically with command\n\n"
printf "5) Media:\n\tTools:\n\t- urldecode: decode URL-encoded string\n\t- m3ufmt: Fix m3u file\n\t- fftrim: Trim video with ffmpeg\n\t- Reencode video to h264\n\n"

printf "all) \n\tApply all\n\n"
printf "\nEnter your choice: "
read choice

ALL=${SITE_URL}/aliases/all.sh
TOOLS=${SITE_URL}/aliases/tools.sh
VAGRANT=${SITE_URL}/aliases/vagrant.sh
KUBECTL=${SITE_URL}/aliases/kubectl.sh
KDE=${SITE_URL}/aliases/kde.sh
MEDIA=${SITE_URL}/aliases/tools.sh

if [ "$choice" = "all" ]; then
    source <(curl -s ${ALL})
elif [ "$choice" = "1" ] || [ "$choice" = "1y" ]; then
    if [ "$choice" = "1y" ]; then
        source <(curl -s ${TOOLS})
    else
        curl -s ${TOOLS}
        printf "\n\nDo you want to source this? (y/n) "
        read apply
        if [[ $apply == "y" ]]; then
            source <(curl -s ${TOOLS})
        fi
    fi
elif [ "$choice" = "2" ] || [ "$choice" = "2y" ]; then
    if [ "$choice" = "2y" ]; then
        source <(curl -s ${VAGRANT})
    else
        curl -s ${VAGRANT}
        printf "\n\nDo you want to source this? (y/n) "
        read apply
        if [[ $apply == "y" ]]; then
            source <(curl -s ${VAGRANT})
        fi
    fi
elif [ "$choice" = "3" ] || [ "$choice" = "3y" ]; then
    if [ "$choice" = "3y" ]; then
        source <(curl -s ${KUBECTL})
    else
        curl -s ${KUBECTL}
        printf "\n\nDo you want to source this? (y/n) "
        read apply
        if [[ $apply == "y" ]]; then
            source <(curl -s ${KUBECTL})
        fi
    fi
elif [ "$choice" = "4" ] || [ "$choice" = "4y" ]; then
    if [ "$choice" = "4y" ]; then
        source <(curl -s ${KDE})
    else
        curl -s ${KDE}
        printf "\n\nDo you want to source this? (y/n) "
        read apply
        if [[ $apply == "y" ]]; then
            source <(curl -s ${KDE})
        fi
    fi
elif [ "$choice" = "5" ] || [ "$choice" = "5y" ]; then
    if [ "$choice" = "5y" ]; then
        source <(curl -s ${MEDIA})
    else
        curl -s ${MEDIA}
        printf "\n\nDo you want to source this? (y/n) "
        read apply
        if [[ $apply == "y" ]]; then
            source <(curl -s ${MEDIA})
        fi
    fi
else
    printf "\n\nInvalid choice.\n"
fi