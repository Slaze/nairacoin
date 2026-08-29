#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
  build-essential cmake git pkg-config ca-certificates \
  libboost-all-dev libssl-dev libzmq3-dev libunbound-dev \
  libsodium-dev libunwind-dev liblzma-dev libreadline-dev \
  libexpat1-dev libpgm-dev libhidapi-dev libusb-1.0-0-dev \
  libprotobuf-dev protobuf-compiler libudev-dev
mkdir -p /src/build
cd /src/build
cmake -D CMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DBUILD_GUI=OFF ..
cmake --build . --target gen_genesis -j"$(nproc)"
./bin/nairacoin-gen-genesis
