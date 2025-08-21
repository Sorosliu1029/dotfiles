if [ "$1" == "Home" ]; then
    # when location is in 'Home'
    osascript -e "set volume without output muted"
    :
elif [ "$1" == "Automatic" ]; then
    # when other locations
    osascript -e "set volume with output muted"
    :
fi
