alias k="kubectl"
alias kg="kubectl get"
alias kgall="kubectl get --all-namespaces all"
alias kd="kubectl describe"
alias kl="kubectl logs"

kns () {
    kubectl config set-context --current --namespace=$1
}

ksec () {
    ## Description:
    # ksec is a wrapper around kubectl get secret and will try to find a secret and decode it
    ## Usage:
    # ksec <secret>
    # ksec <secret> -n <namespace>
    # ksec <secret> -k <key>
    ## Info:
    # Without giving a data key, ksec will list all data keys. `jq` is required for this.
    ## Example:
    # ksec -n argocd argocd-initial

    local OPTIND n k
    while getopts ":n:k:" opt; do
        case $opt in
            n) namespace=$OPTARG;;
            k) key=$OPTARG;;
            \?) echo "Invalid option -$OPTARG" >&2;;
        esac
    done

    secret=${@:$OPTIND:1}

    if [[ -z $secret ]]; then
        echo "No secret provided"
        return 1
    fi

    if [[ ! -z $namespace ]]; then
        echo "Trying to find $secret in $namespace"
        secret_name=$(kubectl get secrets -n $namespace | grep $secret | awk '{print $1}')

        if [[ -z $secret_name ]]; then
            echo "No secret found"
            return 1
        fi

        if [[ ! -z $key ]]; then
            echo "Trying to find $key in $secret_name"
            kubectl get secret -n $namespace $secret_name -ojsonpath="{.data['$key']}" | base64 -d
        else
            echo "Trying to find keys in $secret_name"
            kubectl get secret -n $namespace $secret_name -o json | jq '.data | map_values(@base64d)'
        fi
    else
        echo "Trying to find $secret in current namespace"
        secret_name=$(kubectl get secrets | grep $secret | awk '{print $1}')

        if [[ -z $secret_name ]]; then
            echo "No secret found"
            return 1
        fi

        if [[ ! -z $key ]]; then
            echo "Trying to find $key in $secret_name"
            kubectl get secret $secret_name -o jsonpath="{.data['$key']}" | base64 -d
        else
            echo "Trying to find keys in $secret_name"
            kubectl get secret $secret_name -o json | jq '.data | map_values(@base64d)'
        fi
    fi


}

kx () {
    ## Description:
    # kx is a wrapper around kubectl exec and will try to find a pod and exec into it
    ## Usage:
    # kx <pod> <command>
    # kx <pod> -n <namespace> <command>
    ## Info:
    # pod will be grepped for, so it can be a prefix or fuzzy match
    # command defaults to /bin/sh
    ## Example:
    # kx -n argocd repo-server

    local OPTIND n
    while getopts ":n:" opt; do
        case $opt in
            n) namespace=$OPTARG;;
            \?) echo "Invalid option -$OPTARG" >&2;;
        esac
    done

    pod=${@:$OPTIND:1}
    command=${@:$OPTIND+1:1}

    if [[ -z $command ]]
    then
        command="/bin/sh"
    fi

    if [[ -z $pod ]]; then
        echo "No pod provided"
        return 1
    fi

    if [[ ! -z $namespace ]]; then
        echo "Trying to find $pod in $namespace"
        pod_name=$(kubectl get pods -n $namespace | grep $pod | awk '{print $1}')

        if [[ -z $pod_name ]]; then
            echo "No pod found"
            return 1
        fi

        kubectl exec -n $namespace -it $pod_name -- $command
    else
        echo "Trying to find $pod in current namespace"
        pod_name=$(kubectl get pods | grep $pod | awk '{print $1}')

        if [[ -z $pod_name ]]; then
            echo "No pod found"
            return 1
        fi

        kubectl exec -it $pod_name -- $command
    fi
}

kfw () {
    ## Description:
    # kx is a wrapper around kubectl forward and will try to find a service and forward to it
    ## Usage:
    # kfw <svc> <ports>
    # kfw <svc> -n <namespace> <ports>
    # kfw -t pod <pod> <ports>
    ## Info:
    # svc will be grepped for, so it can be a prefix or fuzzy match
    # a type can be given with -t, defaults to svc
    ## Example:
    # kfw -n argocd argocd-server 8080:443
    
    local OPTIND n t
    while getopts ":n:t:" opt; do
        case $opt in
            n) namespace=$OPTARG;;
            t) type=$OPTARG;;
            \?) echo "Invalid option -$OPTARG" >&2;;
        esac
    done

    svc=${@:$OPTIND:1}
    ports=${@:$OPTIND+1:1}

    if [[ -z $ports ]]; then
        echo "No ports provided"
        return 1
    fi

    if [[ -z $svc ]]; then
        echo "No svc provided"
        return 1
    fi

    if [[ -z $type ]]; then
        type="svc"
    fi

    if [[ ! -z $namespace ]]; then
        echo "Trying to find $type/$svc in $namespace"
        svc_name=$(kubectl get $type -n $namespace | grep $svc | awk '{print $1}')

        if [[ -z $svc_name ]]; then
            echo "No svc found"
            return 1
        fi

        kubectl port-forward -n $namespace $type/$svc_name $ports
    else
        echo "Trying to find $svc in current namespace"
        svc_name=$(kubectl get $type | grep $svc | awk '{print $1}')

        if [[ -z $svc_name ]]; then
            echo "No svc found"
            return 1
        fi

        kubectl port-forward $type/$svc_name $ports
    fi

}
