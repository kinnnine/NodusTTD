#!/bin/bash
# https://github.com/OpenTTD/OpenTTD/blob/15.3/os/emscripten/README.md

cd OpenTTD_base

(
	cd os/emscripten
	docker build -t emsdk-openttd .
)

mkdir build-host
docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) --workdir $(pwd)/build-host emsdk-openttd cmake .. -DOPTION_TOOLS_ONLY=ON
docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) --workdir $(pwd)/build-host emsdk-openttd make -j$(nproc) tools

mkdir build
docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) --workdir $(pwd)/build emsdk-openttd emcmake cmake .. -DHOST_BINARY_DIR=../build-host -DCMAKE_BUILD_TYPE=Release -DOPTION_USE_ASSERTS=OFF
docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) --workdir $(pwd)/build emsdk-openttd emmake make -j$(nproc)

ls -lha build
