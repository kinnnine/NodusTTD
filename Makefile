all: prepare build dist

prepare:
	./scripts/prepare_openttd_src.sh

build:
	./scripts/patch_openttd.sh
	./scripts/build_openttd.sh

dist:
	./scripts/dist_openttd.sh

clean:
	rm -rf OpenTTD_base
	rm -rf dist

prepareDev: prepare
	./scripts/setup_dev.sh
	./scripts/patch_openttd.sh dev

genPatches:
	./scripts/make_patches.sh

cleanDev:
	rm -rf OpenTTD_work

cleanPatches:
	rm -rf patches && mkdir patches
	: > patches/patchlist.txt