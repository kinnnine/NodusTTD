#!/bin/bash

[ -d OpenTTD_work ] && \
	echo "OpenTTD_work still exists, manual user deletion required." && exit 1

cp -r OpenTTD_base OpenTTD_work