#! /bin/bash
# This script change the background.
# It needs a file called WallpaperActual.txt in the folder with all wallpapers.
# Add argument "p" to background the previous picture
# Add argument "N" to pass 5 pictures
# Add argument "P" to go back 5 photos before
# Fond d'écran changeant automatiquement :
#		gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/Spidey/Spidey.xml"
#		gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/gnome/Stones.jpg"

# kill WallpaperAuto
valeur=`ps -e | grep WallpaperAuto | awk '{print $1}'`
echo "chang=$valeur"
if [[ $valeur != *[[:digit:]]* ]]; then
	kill -g ChangementWallpaper.sh
fi

folder="/usr/share/backgrounds/Spidey" # path to get beackground pictures
echo "Change wallpaper from folder $folder"
#images_dispo=`ls $dossierimages`
#nbFile=$(find $dossierimages -type f | wc -l)

imageActu=`cat $folder/WallpaperActual.txt`
numImage=0
count=0
# Copie les fichiers wallpaper dans le tableau $tabPhotos[@] et cherche le numéro du fond d'écran : $numImage
for wallpaper in "$folder"/*.jpg
do
	tabPhotos=("${tabPhotos[@]}" "${wallpaper}")
	if [[ $wallpaper == $imageActu ]]; then
		numImage=$count
	fi
	count=$(($count+1))
done

if [[ $1 == "p" ]]; then
	numImage=$(($numImage-1))
elif [[ $1 == "N" ]]; then
	numImage=$(($(($numImage+5)) % ${#tabPhotos[@]}))
elif [[ $1 == "P" ]]; then
	numImage=$(($numImage-5))
else
	numImage=$(($numImage+1))
fi
# < 0 ou > nombre d'images
if [[ $numImage -lt '0' ]]; then
	numImage=$((${#tabPhotos[@]}+$numImage))
elif [[ $numImage -ge ${#tabPhotos[@]} ]]; then
	numImage=0
fi
echo tabPhotos[0]=${tabPhotos[$numImage]}
echo numImage=$numImage

#Remove first lane
head -n 1 $folder/WallpaperActual.txt > $folder/WallpaperActual.txt 
echo ${tabPhotos[$numImage]} >> $folder/WallpaperActual.txt

gsettings set org.gnome.desktop.background picture-uri "file://${tabPhotos[$numImage]}"

exit 0
