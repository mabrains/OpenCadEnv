# Mabrains Engineers Environment Setup Scripts

This repo is made to enable all engineers to build multiple versions and use multiple versions of all tools at any time on your machine.
We use `Environment Modules` on Linux to allow switching between tools versions. Your machine comes with `Environment Modules` pre-install on it and all the packages required to build the tools. More about `Environment Modules` could be found [here](https://modules.readthedocs.io/en/latest/).

Also, a video tutorial about `Environment Modules` could be found [here](https://www.youtube.com/watch?v=0m72ogpnH-s).

## Status
Please note that this repo is now undergoing major updates to make sure it works as expected. Currently, working tools are:
- klayout
- ngspice
- magic
- netgen

Rest are still under checking.

## Prerequisites
First thing, you will need to add this to your bashrc to make sure that `Environment Modules` are working properly in your terminals:
```bash
source /usr/local/Modules/init/bash
```

## How to use this repo and install any tool version:
To install the tools on your user, you need to do the following:
```bash
export ENV_PATH=/home/$USER/ic-tools
make build_klayout-v0.28.3
```

You could change the version of the tool and the version in the make command like:
```bash
make build_ngspice-38
```

At the end, please make sure to add the following lines in your bashrc:
```bash
source /usr/share/modules/init/bash
module use --append /home/$USER/ic-tools/modulefiles
```
