# Copyright 2022 Mabrains
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# 

# =================================================================================================================
# ----------------------------------------------- Tools Installation ----------------------------------------------
# =================================================================================================================

CC=g++
SHELL:=/bin/bash

# ==== Tools path ====
ENV_PATH         ?= "$$HOME/ic-tools"
PDK_ROOT         ?= "$$HOME/ic-tools/pdks"
setup_path	     ?= $(abspath $(shell pwd))

# ==== tools versions ====
## trilinos-release-$(trilinos_version).tar.gz

# ==== links ====
klayout_link          ="https://github.com/KLayout/klayout.git"
xschem-gaw_link       ="https://github.com/StefanSchippers/xschem-gaw.git"
xschem_link           ="https://github.com/StefanSchippers/xschem.git"
trilinos_link         ="https://github.com/trilinos/Trilinos/archive/refs/tags/"
xyce_link             ="https://github.com/Xyce/Xyce.git"
magic_link            ="https://github.com/RTimothyEdwards/magic.git"
netgen_link           ="https://github.com/RTimothyEdwards/netgen.git"

# ==== MAKE TARGETS =====
tools_srcs:
	@mkdir -p  tools_srcs

env_dir:
	@mkdir -p  $(ENV_PATH)/modulefiles

pdks_dir:
	@mkdir -p  $(PDK_ROOT)

OpenLane_dir:
	@mkdir -p  $(OPENLANE_PATH)


# =========================================================================================== 
# --------------------------- Checks and Layout Tools Installation --------------------------
# ===========================================================================================

###############
## klayout
###############
.ONESHELL:
download_klayout:
	@cd tools_srcs/
	@sh -c "if [ -d klayout ]; then \
				echo 'klayout src is already exist. Updating folder.';\
				cd klayout;\
				git pull;\
				git fetch --tags;\
			else \
				git clone $(klayout_link); \
            fi"

.ONESHELL:
install_klayout-% : tools_srcs env_dir download_klayout
	@sh -c "if [ -d $(ENV_PATH)/tools/klayout-$* ]; then \
				echo 'klayout is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/klayout-$*;\
                cd tools_srcs/klayout ;\
				git checkout $*;\
				./build.sh -j$$(nproc) ;\
				mv -f build-release/ bin-release/ $(ENV_PATH)/tools/klayout-$*/;\
            fi"

build_klayout-% : install_klayout-%
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=klayout --version=$* --bin=bin-release  --lib=bin-release


###############
## magic
###############
.ONESHELL:
download_magic:
	@cd tools_srcs/
	@sh -c "if [ -d magic ]; then \
				echo 'magic src is already exist. Updating folder';\
				cd magic;\
				git pull;\
				git fetch --tags;\
			else \
				git clone $(magic_link); \
            fi"

.ONESHELL:
install_magic-% : tools_srcs env_dir download_magic
	@sh -c "if [ -d $(ENV_PATH)/tools/magic-$* ]; then \
				echo 'magic is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/magic-$*;\
                cd tools_srcs/magic ;\
				git checkout $*;\
				./configure prefix=$(ENV_PATH)/tools/magic-$*;\
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_magic-% : install_magic-%
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=magic --version=$* --bin=bin  --lib=lib

###############
## netgen
###############
.ONESHELL:
download_netgen:
	@cd tools_srcs/
	@sh -c "if [ -d netgen ]; then \
				echo 'netgen src is already exist. Updating folder';\
				cd netgen;\
				git pull;\
				git fetch --tags;\
			else \
				git clone $(netgen_link); \
            fi"

.ONESHELL:
install_netgen-% : tools_srcs env_dir download_netgen
	@sh -c "if [ -d $(ENV_PATH)/tools/netgen-$* ]; then \
				echo 'netgen is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/netgen-$*;\
                cd tools_srcs/netgen ;\
				git checkout $*;\
				./configure prefix=$(ENV_PATH)/tools/netgen-$*;\
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_netgen-% : install_netgen-%
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=netgen --version=$* --bin=bin  --lib=lib


###############
## ngspice
###############
.ONESHELL:
download_ngspice-% : tools_srcs env_dir
	@cd tools_srcs/
	@sh -c "if [ -d ngspice-$* ]; then \
				echo 'ngspice src is already exist';\
			else \
				wget -O ngspice-$*.tar.gz https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/$*/ngspice-$*.tar.gz;\
				tar zxvf ngspice-$*.tar.gz;\
            fi"

.ONESHELL:
install_ngspice_lib-% : download_ngspice-%
	@sh -c "if [ -d $(ENV_PATH)/tools/ngspice-$*/lib ]; then \
				echo 'ngspice lib is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/ngspice-$*/lib;\
                mkdir -p tools_srcs/ngspice-$*/build-lib ;\
				cd tools_srcs/ngspice-$*/build-lib;\
				../configure prefix=$(ENV_PATH)/tools/ngspice-$* --enable-cider --enable-xspice --enable-openmp --enable-pss --with-readline=yes --disable-debug --with-x --with-ngshared;\
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
install_ngspice-% : download_ngspice-%
	@sh -c "if [ -d $(ENV_PATH)/tools/ngspice-$*/bin ]; then \
				echo 'ngspice is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/ngspice-$*/bin;\
                mkdir -p tools_srcs/ngspice-$*/release ;\
				cd  tools_srcs/ngspice-$*/release;\
				../configure prefix=$(ENV_PATH)/tools/ngspice-$* --enable-cider --enable-xspice --enable-openmp --enable-pss --with-readline=yes --disable-debug --with-x
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_ngspice-% : install_ngspice_lib-% install_ngspice-%
	/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=ngspice --version=$* --bin=bin  --lib=lib

###############
## xschem
###############
.ONESHELL:
download_gaw3: tools_srcs env_dir
	@cd tools_srcs/
	@sh -c "if [ -d xschem-gaw ]; then \
				echo 'xschem-gaw src is already exist';\
			else \
				git clone $(xschem-gaw_link);\
            fi"

.ONESHELL:
install_gaw3: download_gaw3
	@sh -c "if [ -d $(ENV_PATH)/tools/xschem-gaw ]; then \
				echo 'xschem-gaw is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/xschem-gaw;\
                cd tools_srcs/xschem-gaw ;\
				autoreconf -i;\
				./configure prefix=$(ENV_PATH)/tools/xschem-gaw;\
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_gaw3: install_gaw3
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=xschem-gaw --version=head --bin=bin  --lib=lib

.ONESHELL:
download_xschem: tools_srcs env_dir
	@cd tools_srcs/
	@sh -c "if [ -d xschem ]; then \
				echo 'xschem src is already exist';\
			else \
				git clone $(xschem_link);\
            fi"

.ONESHELL:
install_xschem: download_xschem
	@sh -c "if [ -d $(ENV_PATH)/tools/xschem-$(xschem_version) ]; then \
				echo 'xschem is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/xschem-$(xschem_version);\
                cd tools_srcs/xschem ;\
				git checkout $(xschem_version);\
				./configure prefix=$(ENV_PATH)/tools/xschem-$(xschem_version);\
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_xschem: build_gaw3 install_xschem
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=xschem --version=$(xschem_version) --bin=bin  --lib=.

###############
## xyce
###############
.ONESHELL:
download_trilinos: tools_srcs env_dir
	@cd tools_srcs/
	@sh -c "if [ -d Trilinos-trilinos-release-$(trilinos_version) ]; then \
				echo 'Trilinos src is already exist';\
			else \
				wget $(trilinos_link);\
				tar zxvf trilinos-release-$(trilinos_version).tar.gz;\
            fi"

.ONESHELL:
install_trilinos: download_trilinos
	@sh -c "if [ -d $(ENV_PATH)/tools/trilinos-$(trilinos_version) ]; then \
				echo 'Trilinos is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/trilinos-$(trilinos_version);\
                mkdir -p tools_srcs/Trilinos-trilinos-release-$(trilinos_version)/parallel_build ;\
				cp cmake_init.sh tools_srcs/Trilinos-trilinos-release-$(trilinos_version)/parallel_build;\
				cd tools_srcs/Trilinos-trilinos-release-$(trilinos_version)/parallel_build;\
				chmod +x cmake_init.sh;\
				./cmake_init.sh  $(ENV_PATH)/tools/trilinos-$(trilinos_version);\
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_trilinos: install_trilinos
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=trilinos --version=$(trilinos_version) --bin=.  --lib=lib

.ONESHELL:
download_xyce: tools_srcs env_dir
	@cd tools_srcs/
	@sh -c "if [ -d Xyce ]; then \
				echo 'Xyce src is already exist';\
			else \
				git clone $(xyce_link);\
            fi"

.ONESHELL:
install_xyce: download_xyce
	@sh -c "if [ -d $(ENV_PATH)/tools/Xyce-$(xyce_version) ]; then \
				echo 'Xyce is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/Xyce-$(xyce_version);\
                cd tools_srcs/Xyce ;\
				git checkout $(xyce_version);\
				./bootstrap;\
				mkdir build_dir;\
				cd build_dir;\
				../configure CXXFLAGS="-O3" ARCHDIR="$(ENV_PATH)/tools/trilinos-$(trilinos_version)" CPPFLAGS="-I/usr/include/suitesparse" --enable-mpi CXX=mpicxx CC=mpicc F77=mpif77 --enable-stokhos --enable-amesos2 --enable-shared --enable-xyce-shareable --prefix=$(ENV_PATH)/tools/Xyce-$(xyce_version)
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_xyce: build_trilinos install_xyce
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=Xyce --version=$(xyce_version) --bin=bin  --lib=lib
	@echo "module load trilinos/$(trilinos_version)" >> $(ENV_PATH)/modulefiles/Xyce/$(xyce_version)


# =========================================================================================== 
# ---------------------------------------- CLEAN SRCS ---------------------------------------
# ===========================================================================================

clean_builds:
	rm -rf tools_srcs
