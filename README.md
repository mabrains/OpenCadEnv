# Open CAD Environment

Open CAD Environment repo is aiming to create a professional grade envionment for EE engineers to be able to use Open Source tools for IC design much easier. We use `Enviroment Modules` to track which verison of each tool we are using as used in the professional environments. This allow switching between different versions of the tools much easier and maintaining versions correctly.

More about `Environment Modules` could be found [here](https://modules.readthedocs.io/en/latest/).
Also, a video tutorial about `Environment Modules` could be found [here](https://www.youtube.com/watch?v=0m72ogpnH-s).

## Status
Originally, we internally used to support all tools. But due rapid change in building process for tools, we were not able to keep up. I stipped down the list of tools to a target set of tools. Currently, we only support the following list of tools:
- klayout
- ngspice
- magic
- netgen

Please try to contribute to this project if you can. We are opening this to the community to allow easier management of tools.

## Testing
This has been tested on `Ubuntu 22.04`. We appreciate if you could test on different environments.

## Installation
You must first must install all the libraries necessary for building all tools from scratch. To do that you need to do the following:
```bash
git clone https://github.com/mabrains/OpenCadEnv.git
cd OpenCadEnv
sudo bash ./install_libraries.sh
```

By default, the build process will build inside:
```bash
/home/$USER/ic-tools
``` 

You could change the location of tools, by changing that path like this:
```bash
export ENV_PATH=<path_of_installation>
```

You must add the following lines at the bottom of your `.bashrc` to be able to use this environment:
```bash
export ENV_PATH=<path_of_installation>
source /usr/share/modules/init/bash
module use --append $ENV_PATH/modulefiles
```

If you are using the default location of installation, you could just copy the following:
```bash
export ENV_PATH=/home/$USER/ic-tools
source /usr/share/modules/init/bash
module use --append $ENV_PATH/modulefiles
```

## How to use this repo and install any tool version you want:
To install a tool with a specific version, you could do something like:
```bash
make build_klayout-v0.28.3
```

You could change the version of the tool and the version in the make command like:
```bash
make build_ngspice-38
```

## How to use environment modules
Once everything is installed, you could now see all the versions of all the tools installed using the following command:
```bash
module avail
```

Example output:
![module avail output](./images/module_avail.png?raw=true)

To load a tool in your environment:
```bash
module load klayout/v0.28.7
```

Example output
![module avail output](./images/module_load.png?raw=true)


To unload a tool in your environment:
```bash
module unload klayout/v0.28.7
```

Example output
![module avail output](./images/module_unload.png?raw=true)


