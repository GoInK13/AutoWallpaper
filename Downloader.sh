#! /bin/bash
# This script download all pictures begining with linkStart and ending with linkEnd.
# Ex :
# Number of pictures=100
# linkStart="https://dncache-mauganscorp.netdna-ssl.com/cropped-wallpapers/1983/19839"
# linkEnd="-1366x768-[DesktopNexus.com].jpg"
# name="wallpaper"

echo -en number of pictures : 
read maxFor
echo -en Begin of link :
read linkStart
echo -en End of link :
read linkEnd
echo -en output name :
read name

for (( i = 1; i < $maxFor; i++ )); do
	wget $linkStart$i$linkEnd -O $name$i
done

exit 0
