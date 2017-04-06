#!/bin/bash
###################################
# Semi automatic APV menu generator
###################################
# Call it with APV-PosterExtractor.sh <projection folder>
# For each video file in the folder, it plays the video,
# then wait for you to enter the timestamp of the frame
# you want as a poster. Then it asks the title of the video
# and uses this information to create a ready-to-go JSON file
# to be incorporated to APV 2013's video data file.

if [ -z $1 ]; then
    exit 1
fi

#Parameters
videos_folder=$1
posters_folder=$1/posters
json_file=$posters_folder/projection.json

mkdir $posters_folder
echo $(printf '[\n') >> $json_file

#Deals with complex file names
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

#The first loop : encodes with constant quality
for video in $(find "$videos_folder" -maxdepth 1 -type f -name "*.mp4" | sort)
do
    filename=$(basename $video)
    echo "Nom du fichier : "$filename
    poster="$posters_folder/${filename%.mp4}.png"
    nohup vlc $video &>/dev/null &
    read -p "Timestamp de la frame sous la forme mm:ss : " instant
    ffmpeg -loglevel error -i "$video" -ss 00:$instant -vframes 1 -y "$poster"
    convert "$poster" -resize 250x444 "$poster"
    read -p "Titre de la vidéo : " title
    echo $(printf '{\r
    "poster": "%s",\r
    "src": "%s",\r
    "title": "%s"\r
},' ${filename%.mp4}.png $filename $title) >> $json_file
done

echo $(printf ']\n') >> $json_file

#Restores filename dealing configuration
IFS=$SAVEIFS
