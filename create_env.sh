echo '#interface'
echo 'interface='$(ls -l /sys/class/net/ | grep -v virtual  | grep -v 'total' | awk '{print $9}' | tr '\n' ',')''
echo '#ip range'
echo 'iprange_low='$(for e in $(ls -l /sys/class/net/ | grep -v virtual  | grep -v 'total' | awk '{print $9}'); do ifconfig | grep -1 $e | grep inet | awk '{print $2}';done | awk 'BEGIN{ FS = "."} {print $1"."$2"."$3".201"}')
echo 'iprange_high='$(for e in $(ls -l /sys/class/net/ | grep -v virtual  | grep -v 'total' | awk '{print $9}'); do ifconfig | grep -1 $e | grep inet | awk '{print $2}';done | awk 'BEGIN{ FS = "."} {print $1"."$2"."$3".245"}')
echo '#server ip'
echo 'server_ip='$(for e in $(ls -l /sys/class/net/ | grep -v virtual  | grep -v 'total' | awk '{print $9}'); do ifconfig | grep -1 $e | grep inet | awk '{print $2}';done)
echo '#http'
echo 'focal=/home/'$(whoami)'/Downloads/ubuntu-20.04.1-live-server-amd64.iso'
