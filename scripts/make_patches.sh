#!/bin/bash

PATCHLIST="patches/patchlist.txt"

rm -rf patches && mkdir patches

diff -rqa OpenTTD_base/ OpenTTD_work/ | awk '{print $2}' > "$PATCHLIST"

while IFS= read -r line
do
	FILEPATH="${line/'OpenTTD_base/'/}"
	PARENTPATH="${FILEPATH%/*}"
	mkdir -p patches/"$PARENTPATH"
	diff -Naru "$line" OpenTTD_work/"$FILEPATH" | sed -re '1,2 s/\t.*//' > patches/"$FILEPATH".patch
	echo "$line Done."
done < "$PATCHLIST"
