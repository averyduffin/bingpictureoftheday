home="/Users/averyduffin"

PICTURE_DIR="$home/Pictures/bing-wallpapers/"

mkdir -p $PICTURE_DIR

uuid=$(uuidgen)

urls=( $(curl -s https://www.bing.com/ | \
    grep -Eo "url:'.*?'" | \
    sed -e "s/url:'\([^']*\)'.*/https:\/\/bing.com\1/" | \
    sed -e "s/\\\//g") )

for p in ${urls[@]}; do
    filename="1.jpg"
    # if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $filename ..."
        curl -Lo "$PICTURE_DIR/$filename" $p
    # else
    #     echo "Skipping: $filename ..."
    # fi
done

ImageFilePath=$PICTURE_DIR/$filename

killall Dock

# sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$ImageFilePath'" && killall Dock;

# osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/averyduffin/Pictures/bing-wallpapers/1.jpg"'
# killall Dock
