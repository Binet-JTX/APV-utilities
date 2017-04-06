#!/bin/bash

#Creates a temp directory from which it makes the encoding
#Necessary for different processes not to overlap
temp_dir=$(mktemp -t -d -p ./)
cd $temp_dir

#Parameters
folder_to_encode="../"$1
audio_bitrate=$(echo "192*10^3" | bc)

#Deals with complex file names
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

mkdir "$folder_to_encode/encoding_final_output"
for music in $(find "$folder_to_encode" -maxdepth 1 -type f -name "*.wav" | sort )
do
    filename=$(basename $music)
    ffmpeg -i "$music" -c:a libmp3lame -b:a 192k -y "$folder_to_encode/encoding_final_output/${filename%.wav}.mp3"
    printf "[%s] encodage de %s effectué.\n" $(date +%H:%M:%S) $music >> ../APV-Encoder.log
done

printf "========================================
[%s] encodage (vers mp3) de %s effectué.
========================================\n" $(date +%H:%M:%S) $folder_to_encode >> ../APV-Encoder.log

cd ../
rm -rf $temp_dir

#Restores filename dealing configuration
IFS=$SAVEIFS
