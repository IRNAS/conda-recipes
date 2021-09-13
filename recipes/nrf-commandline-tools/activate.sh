#!/usr/bin/env bash
export INVOKE_PATHS_JDLL="${CONDA_PREFIX}/nrf-command-line-tools/JLink/libjlinkarm.so"
alias nrfjprog="nrfjprog --jdll ${CONDA_PREFIX}/nrf-command-line-tools/JLink/libjlinkarm.so"
