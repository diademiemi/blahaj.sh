printf "\n\nAvailable Aliases/Functions:\n\n"
printf "1) Tools: \n\tgenpasswd, getip, mkcd, rsed, chext, sshb\n\n"
printf "2) Vagrant: \n\tvag, vup, vde, vha, vssh, sshc, vsshc\n\n"
printf "3) Kubectl: \n\tk,kg,kd,kl\n\n"
printf "4) KDE: \n\tsplitkonsole\n\n"

printf "all) \n\tApply all\n\n"
printf "\nEnter your choice: "
read choice

ALL=${SITE_URL}/aliases/all.sh
TOOLS=${SITE_URL}/aliases/tools.sh
VAGRANT=${SITE_URL}/aliases/vagrant.sh
KUBECTL=${SITE_URL}/aliases/kubectl.sh
KDE=${SITE_URL}/aliases/kde.sh

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
else
    printf "\n\nInvalid choice.\n"
fi