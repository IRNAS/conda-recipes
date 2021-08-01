#!/usr/bin/env bash

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done

export TARGET=nrf-command-line-tools
export JLINK=JLink
export TARGET_PREFIX="${PREFIX}/${TARGET}"

mkdir -p "${PREFIX}"/bin
mkdir -p "${TARGET_PREFIX}"

# Unpack, the zip that you donwload gets unzipped in the process.
tar -xzvf nRF-Command-Line-Tools*.tar.gz

tar -xf nRF-Command-Line-Tools*.tar 
tar -xzf JLink_Linux*.tgz

# Cleanup
rm nRF-Command-Line-Tools*.tar.gz
rm nRF-Command-Line-Tools*.tar 
rm nRF-Command-Line-Tools*.deb
rm JLink_Linux*.tgz
rm JLink_Linux*.deb

mv JLink_Linux_V* ${JLINK}

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
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkExe ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkGDBServer ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkRTTClient ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkRTTLogger ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkRTTViewerExe ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkRemoteServer ./
    ln -s ../"${TARGET}"/"${JLINK}"/JLinkSWOViewer ./
    ln -s ../"${TARGET}"/mergehex/mergehex ./
    ln -s ../"${TARGET}"/nrfjprog/nrfjprog ./
popd
