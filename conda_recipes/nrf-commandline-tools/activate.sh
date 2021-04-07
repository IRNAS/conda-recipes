#!/usr/bin/env bash
export INVOKE_JDLL_PATH="${CONDA_PREFIX}/nrf-command-line-tools/JLink/libjlinkarm.so"
alias nrfjprog="nrfjprog --jdll ${CONDA_PREFIX}/nrf-command-line-tools/JLink/libjlinkarm.so"
