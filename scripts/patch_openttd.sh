#!/bin/bash

PATCHLIST="patches/patchlist.txt"

if [ "$1" = "dev" ]; then
	SUFFIX="work"
else
	SUFFIX="base"
fi

while IFS= read -r line
do
	FILEPATH="${line/'OpenTTD_base/'/}"
	(
		cd OpenTTD_"$SUFFIX"
		patch -p1 < ../patches/"$FILEPATH".patch
	)
done < "$PATCHLIST"