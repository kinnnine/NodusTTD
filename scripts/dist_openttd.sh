#!/bin/bash

[ ! -d OpenTTD_base/build ] && \
	echo "Missing OpenTTD_base/build folder, run 'make build' first." && exit 1

rm -rf dist && mkdir dist

cp -v OpenTTD_base/build/openttd.data	dist/openttd.data
cp -v OpenTTD_base/build/openttd.js		dist/openttd.js
cp -v OpenTTD_base/build/openttd.wasm	dist/openttd.wasm
cp -v OpenTTD_base/build/openttd.html	dist/index.html