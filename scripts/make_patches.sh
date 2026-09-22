#!/bin/bash

PATCHLIST="patches/patchlist.txt"

rm -rf patches && mkdir patches

diff -Nrqa OpenTTD_base/ OpenTTD_work/ | \
	awk '{print $2}' > "$PATCHLIST"

diff -rqa OpenTTD_base/ OpenTTD_work/ | \
	awk '/^Only in / {sub(/:/, "/"); sub(/OpenTTD_work/, "OpenTTD_base"); print $3 $4}'  >> "$PATCHLIST"

while IFS= read -r line
do
	FILEPATH="${line/'OpenTTD_base/'/}"
	PARENTPATH="${FILEPATH%/*}"
	mkdir -p patches/"$PARENTPATH"
	[ ! -f "$line" ] && line="/dev/null" # if the file inside OpenTTD_base doesn't exist
	diff -u "$line" OpenTTD_work/"$FILEPATH" | sed -re '1,2 s/\t.*//' > patches/"$FILEPATH".patch
	echo "$FILEPATH Done."
done < "$PATCHLIST"
