#! /bin/bash
# Ce programme lancé avec un raccourcis récupère le nom du fond d'écran actuel (Sous la forme Prenom_Nom-$Numero-#$Xsec)et le change au bout de $Xsec secondes

#TODO:Si le programme est relancé sans être terminé, afficher une notif donnant le temps avant le changement de fond d'écran

Spidey="/usr/share/backgrounds/Spidey" # chemin du dossier des images
imageActu=`cat $Spidey/WallpaperActual.txt`

#Cherche l'image suivante:
stop=0
for imgNext in "$Spidey"/*.jpg
do
	if [[ $stop -eq '1' ]]; then
		break
	fi
	if [[ $imgNext == $imageActu ]]; then
		stop=1
	fi
done

#numéro entre category/ et " title
time=${imageActu#*:}
time=${time%.jpg*}

#Si time est un nombre : 10 minutes par défaut
if [[ $time != *[[:digit:]]* ]]; then
	time=600
fi

echo "Dans $time secondes : $imgNext"

sleep $time
gsettings set org.gnome.desktop.background picture-uri "file://$imgNext"

#Supprime la 1ère ligne
head -n 1 /usr/share/backgrounds/Spidey/WallpaperActual.txt > /usr/share/backgrounds/Spidey/WallpaperActual.txt 
echo $imgNext >> $Spidey/WallpaperActual.txt

./WallpaperAuto.sh &

exit 0
