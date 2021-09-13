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

# Unpack, the zip that you download gets unzipped in the process.
tar -xzvf nrf-command-line-tools*.tar.gz

tar -xzf JLink_Linux*.tgz

# Cleanup
rm nrf-command-line-tools*.tar.gz
rm nrf-command-line-tools*.deb
rm nrf-command-line-tools*.rpm
rm pynrfjprog*.zip
rm JLink_Linux*.tgz
rm JLink_Linux*.deb
rm README.txt
rm ReadMe.txt

mv JLink_Linux* ${JLINK}

# Remove extra files
rm -fr "${JLINK}"/Devices
rm -fr "${JLINK}"/Doc
rm -fr "${JLINK}"/Samples

# Move to install location
cp -R nrf-command-line-tools/bin/mergehex ${TARGET_PREFIX}
cp -R nrf-command-line-tools/bin/nrfjprog ${TARGET_PREFIX}
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
    ln -s ../"${TARGET}"/mergehex ./
    ln -s ../"${TARGET}"/nrfjprog ./
popd
