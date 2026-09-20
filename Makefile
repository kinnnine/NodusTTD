all: prepare build

prepare:
	./scripts/prepare_openttd_src.sh

prepareDev: prepare
	./scripts/setup_dev.sh
	./scripts/patch_openttd.sh dev

build:
	./scripts/patch_openttd.sh
	./scripts/build_openttd.sh

genPatches:
	./scripts/make_patches.sh

clean:
	rm -rf OpenTTD_base
	rm -rf dist

cleanDev:
	rm -rf OpenTTD_work

cleanPatches:
	rm -rf patches && mkdir patches
	: > patches/patchlist.txt
