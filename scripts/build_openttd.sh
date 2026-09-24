#!/bin/bash
# https://github.com/OpenTTD/OpenTTD/blob/15.3/os/emscripten/README.md

(
	cd OpenTTD_base/os/emscripten
	docker build -t emsdk-openttd .
)

(
	mkdir OpenTTD_base/build-host
	docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) \
		--workdir $(pwd)/OpenTTD_base/build-host emsdk-openttd cmake .. -DOPTION_TOOLS_ONLY=ON
	docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) \
		--workdir $(pwd)/OpenTTD_base/build-host \
		emsdk-openttd make -j$(nproc) tools

	mkdir OpenTTD_base/build
	docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) \
		--workdir $(pwd)/OpenTTD_base/build emsdk-openttd emcmake cmake .. \
		-DHOST_BINARY_DIR=../build-host -DCMAKE_BUILD_TYPE=Release -DOPTION_USE_ASSERTS=OFF
	docker run -i --rm -v $(pwd):$(pwd) -u $(id -u):$(id -g) \
		--workdir $(pwd)/OpenTTD_base/build emsdk-openttd emmake make -j$(nproc)
)