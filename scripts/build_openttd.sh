#!/bin/bash
# https://github.com/OpenTTD/OpenTTD/blob/15.3/os/emscripten/README.md

NODUSTTD_TAG="$(git tag --points-at HEAD)"
if [ -z "$NODUSTTD_TAG" ]; then
	NODUSTTD_TAG="$(git rev-parse --short HEAD)"
fi

(
	cd OpenTTD_base/os/emscripten
	docker build -t emsdk-openttd .
)

(
	cd OpenTTD_base
	mkdir build-host
	docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) \
		--workdir $(pwd)/build-host emsdk-openttd cmake .. -DOPTION_TOOLS_ONLY=ON
	docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) \
		--workdir $(pwd)/build-host emsdk-openttd make -j$(nproc) tools

	mkdir build
	docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) \
		--workdir $(pwd)/build emsdk-openttd emcmake cmake .. \
		-DHOST_BINARY_DIR=../build-host -DCMAKE_BUILD_TYPE=Release \
		-DOPTION_USE_ASSERTS=OFF -DREV_NODUSTTD_VERSION=$NODUSTTD_TAG
	docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) \
		--workdir $(pwd)/build emsdk-openttd emmake make -j$(nproc)
)