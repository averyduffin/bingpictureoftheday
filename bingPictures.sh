#!/usr/bin/env bash

PICTURE_DIR="$HOME/Pictures/bing-wallpapers/"

mkdir -p $PICTURE_DIR

urls=( $(curl -s https://www.bing.com/?cc=gb | \
    grep -Eo "url:'.*?'" | \
    sed -e "s/url:'\([^']*\)'.*/https:\/\/bing.com\1/" | \
    sed -e "s/\\\//g") )

for p in ${urls[@]}; do
    filename=$(echo $p|sed -e "s/.*\/\(.*\)/\1/")
    if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $filename ..."
        curl -Lo "$PICTURE_DIR/$filename" $p
    else
        echo "Skipping: $filename ..."
    fi
done

ImageFilePath=$PICTURE_DIR/$filename

sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$ImageFilePath'" && killall Dock
