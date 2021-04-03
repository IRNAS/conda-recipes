#!/usr/bin/env bash

export TARGET=nrf-command-line-tools
export JLINK=JLink_Linux_V688a_x86_64
export TARGET_PREFIX="${PREFIX}/${TARGET}"

mkdir -p "${PREFIX}"/bin
mkdir -p "${TARGET_PREFIX}"

# Unpack
tar -xf nRF-Command-Line-Tools_10_12_1.tar 
tar -xzf "${JLINK}".tgz

# Remove extra files
rm -fr "${JLINK}"/Devices
rm -fr "${JLINK}"/Doc
rm -fr "${JLINK}"/Samples

# Move to install location
cp -R mergehex ${TARGET_PREFIX}
cp -R nrfjprog ${TARGET_PREFIX}
cp -R ${JLINK} ${TARGET_PREFIX}

# Symlink every binary from the build into /bin
pushd "${PREFIX}"/bin
    ln -s ../"${TARGET}"/mergehex/mergehex ./
    ln -s ../"${TARGET}"/nrfjprog/nrfjprog ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkExe ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkGDBServer ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkRTTClient ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkRTTLogger ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkRTTViewerExe ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkRemoteServer ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkSWOViewer ./
popd
