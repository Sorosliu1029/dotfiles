if (( ! ${+functions[proxy]} )); then
  proxy() {
    if [[ -z $1 ]]; then
      echo "Usage: proxy <on|off>"
      return 1
    fi

    case $1 in
      on)
        export http_proxy=http://127.0.0.1:7890
        export https_proxy=http://127.0.0.1:7890
        export no_proxy=127.0.0.1,localhost
        export HTTP_PROXY=http://127.0.0.1:7890
        export HTTPS_PROXY=http://127.0.0.1:7890
        export NO_PROXY=127.0.0.1,localhost
        ;;
      off)
        unset http_proxy
        unset https_proxy
        unset no_proxy
        unset HTTP_PROXY
        unset HTTPS_PROXY
        unset NO_PROXY
       ;;
    esac

    return 0
  }
fi
