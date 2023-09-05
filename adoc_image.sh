#!/bin/bash
#
SRC="$HOME/Development/bookbag-aro-mobb/workshop/content"
DEST="$HOME/Development/aro-ilt/documentation/modules/ROOT"

# copy
echo "COPYING CONTENT"
cp -rv "$SRC/" "$DEST/pages"
# change image locations
echo "CONVERTING ADOC IMAGES"
find $DEST/pages -name '*.adoc' -print0 | xargs -0 perl -pi -e 's/^image:.*\/(.*?)$/image:$1/'

# copy images
echo "COPYING IMAGES"
mkdir -p $DEST/images
mv -v $DEST/pages/media/* $DEST/images

# reduce oversized images
echo "RESIZING IMAGES"
du -s $DEST/pages/ $DEST/images
mogrify -resize 1080\> $DEST/images/*.png
du -s $DEST/pages/ $DEST/images

cd ~/Development/aro-ilt; docker run -u $(id -u) -v $PWD:/antora:Z --rm -t antora/antora site.yml