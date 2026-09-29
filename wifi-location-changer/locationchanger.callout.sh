if [ "$1" == "Home" ]; then
    # when location is in 'Home'
    osascript -e "set volume without output muted"
    networksetup -setdnsservers "Wi-Fi" 192.168.1.201 # homelab ad-guard server
    :
elif [ "$1" == "Automatic" ]; then
    # when other locations
    osascript -e "set volume with output muted"
    networksetup -setdnsservers "Wi-Fi" "Empty"
    :
fi
