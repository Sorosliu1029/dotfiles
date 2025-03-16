if (( ! ${+aliases[proxy_on]} )); then
  alias proxy_on="source /etc/profile.d/clash.sh; proxy_on"
  alias proxy_off="source /etc/profile.d/clash.sh; proxy_off"
fi
