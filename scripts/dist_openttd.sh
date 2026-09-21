#!/bin/bash

[ ! -d OpenTTD_base/build ] && \
	echo "Missing OpenTTD_base/build folder, run 'make build' first." && exit 1

rm -rf dist && mkdir dist

cp -v OpenTTD_base/build/openttd.data		dist/openttd.data
cp -v OpenTTD_base/build/openttd.js			dist/openttd.js
cp -v OpenTTD_base/build/openttd.wasm		dist/openttd.wasm
cp -v OpenTTD_base/build/openttd.html		dist/index.html

cp -v public/manifest.json					dist/manifest.json
cp -v public/sw.js 							dist/sw.js

cp -v OpenTTD_base/media/openttd.512.png	dist/logo512.png

convert OpenTTD_base/media/openttd.256.png -define icon:auto-resize=256,64,48,32,16 dist/favicon.ico

NODUSTTD_TAG="$(git tag --points-at HEAD)"
if [ -n "$NODUSTTD_TAG" ]; then
	sed -i "s/NODUSTTD_REV/$NODUSTTD_TAG/g"					dist/index.html
else
	sed -i "s/NODUSTTD_REV/$(git rev-parse --short HEAD)/g"	dist/index.html
	sed -i 's/NodusTTD/NodusTTD Unstable/g'					dist/manifest.json
fi

sed -i "s/OPENTTD_REV/$(cat openttd_version)/g"				dist/index.html