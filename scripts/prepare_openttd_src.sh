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

tar -czf openttd.tar.gz -C OpenTTD_base .
