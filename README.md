# Conda nRF5

## Introduction

This simple repository shows how to setup Conda enviroment for building nrf5 projects.
The main inspiration for this repository was a great blog on a great blog Interrupt: https://interrupt.memfault.com/blog/conda-developer-environments

## Setup
```shell
# Download for Linux:
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# install it
bash Miniconda3-latest-*-x86_64.sh
# Restart shell or open a new Tmux pane
# Disable conda activating at startup
conda config --set auto_activate_base false
```

## Usage
```shell
# Create new environment
conda create -n <env_name>

# To activate it, shell alias is preferred
conda activate <env_name>

# To deactivate it, shell alias is also preferred
conda deactivate

# To remove it
conda env remove -n <env_name>

# To update environment according to a yml file
conda env update -f environment.yml
```

## Configuration

Create a `environment.yml` file with required packages (look inside this repo for an example) and then run: `conda env update -f environment.yml`.

## Building packages

Look into `conda_recipes` for some inspiration on how to build a conda package.
After you created required `meta.yml` and `build.sh` you can create a build environment to
build them and then upload them.

```shell
conda create -n build
conda activate build
conda install -c conda-forge conda-build anaconda-client python=3.7 nlohmann_json protobuf grpc-cpp fmt spdlog pkg-config
conda install -c markosagadin abseil-cpp
conda build .
# Build command will give you a suggestion for upload
anaconda upload ...
```

Lower version of Python is required, due to the error `module 'base64' has no attribute 'encodestring'` inside `anaconda-client` program.

### Creating sha256sum

I have no idea how to do this properly.
You can first set random sha in `meta.yaml` and then run `conda build .`, which will tell you the actual sha, you can just copy it from there.

### Troubleshooting building packages

Command `anaconda upload` can fail silently due to many reasons, there is an issue on GitHub (https://github.com/Anaconda-Platform/anaconda-client/issues/501), where you can find a snipppet of code that you need to paste to a `binstar_client/commands/upload.py` in order to see the actual error.

Errors could be:
* Expired authorization token
* Large file
* Above error with module base64
* And others.

If the last line of the `anaconda upload` command is `Uploading file "..` and nothing else then the error happened.
