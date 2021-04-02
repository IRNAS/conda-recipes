#!/usr/bin/env bash

export TARGET=nrf-command-line-tools
export TARGET_PREFIX="${PREFIX}/${TARGET}"

mkdir -p "${PREFIX}"/bin
mkdir -p "${TARGET_PREFIX}"

tar -xf nRF-Command-Line-Tools_10_12_1.tar 

cp -R mergehex ${TARGET_PREFIX}
cp -R nrfjprog ${TARGET_PREFIX}

# Symlink every binary from the build into /bin
pushd "${PREFIX}"/bin
    ln -s ../"${TARGET}"/mergehex/mergehex ./
    ln -s ../"${TARGET}"/nrfjprog/nrfjprog ./
popd
