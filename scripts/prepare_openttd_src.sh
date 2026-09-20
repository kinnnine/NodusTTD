#!/bin/bash

OPENTTD_REPOURL="https://github.com/OpenTTD/OpenTTD"
OPENTTD_VERSION="$(cat openttd_version)"

if [ -f openttd.tar.gz ]; then
	mkdir OpenTTD_base
	(
		cd OpenTTD_base
		tar xf ../openttd.tar.gz
	)
	exit 0
fi

git clone "$OPENTTD_REPOURL" --branch "$OPENTTD_VERSION" --depth 1 OpenTTD_base

# remove huge folders for size
rm -rf OpenTTD_base/.git OpenTTD_base/.github OpenTTD_base/docs

# truncate any icon and logo files for size
: > OpenTTD_base/media/openttd.svg
for file in OpenTTD_base/media/*.png; do
	: > "$file"
done
for file in OpenTTD_base/media/*.xpm; do
	: > "$file"
done
for file in OpenTTD_base/media/*.bmp; do
	: > "$file"
done

tar -czf openttd.tar.gz -C OpenTTD_base .