#! /bin/bash
# Create automaticaly an xml file to set to background
# Every pictures should have the following name :
# Name_Of_Picture-XX:TIME.jpg
# With XX is an optionnal number
# TIME is the delay you want to have the picture as background in s.
# Ex : Nature_Ocean-01:2000.jpg
# All pictures have to be in the same folder and finish with ".jpg"
# Example : 
# /usr/share/backgrounds/Spidey/
# | ./Nature_Ocean-01:2000.jpg
# | ./Nature_Ocean-02:1000.jpg
# | ./Nature_Ocean-03:2500.jpg
# | ./Nature_Ocean-04:10000.jpg
# | ./Nature_Street-01:60.jpg
# | ./Nature_Street-02:500.jpg

echo -en "Folder of pictures to get: ex:/usr/share/backgrounds/Spidey :"
read folder

if [ -z "$folder" ]; then
	folder="/usr/share/backgrounds/Spidey" # Folder of pictures
fi

exit

echo "<background>
  <starttime>
    <year>2017</year>
    <month>01</month>
    <day>01</day>
    <hour>08</hour>
    <minute>00</minute>
    <second>00</second>
  </starttime>" >> $PWD/folder.xml

for img in "$folder"/*.jpg
do
	time=${img#*:}
	time=${time%.jpg*}
	echo "  <static>
    <duration>$time</duration>
    <file>$img</file>
  </static>" >> $PWD/folder.xml
done
echo "</background>" >> $PWD/folder.xml

exit 0
