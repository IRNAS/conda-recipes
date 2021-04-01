Conda nRF5

# Introduction

This is a simple repository that shows how to setup Conda enviroment for building nrf5 projects.
The main inspiration for this repository was a great blog on a great blog website Interrupt: https://interrupt.memfault.com/blog/conda-developer-environments


# Instructions

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
```

## Configuration

Create a `environment.yml` file with required packages (look inside this repo for an example) and then run: `conda env update -f environment.yml`.
