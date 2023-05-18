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

xyce_link             ="https://github.com/Xyce/Xyce.git"
trilinos_link         ="https://github.com/trilinos/Trilinos/archive/refs/tags/"
suitesparse_link      ="https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/refs/tags/"
trilinos_version      ="14-0-0"
suitesparse_version   ="7.0.1"


# ==== tools versions ====
## trilinos-release-$(trilinos_version).tar.gz


###############
## Downloads
###############
.ONESHELL:
download_suitesparse: ./tools_srcs $(ENV_PATH)/modulefiles
	@cd tools_srcs/
	@sh -c "if [ -d SuiteSparse-$(suitesparse_version) ]; then \
				echo 'SuiteSparse src already exists';\
			else \
				wget $(suitesparse_link)/v$(suitesparse_version).tar.gz;\
				tar zxvf v$(suitesparse_version).tar.gz;\
            fi"

.ONESHELL:
download_trilinos: ./tools_srcs $(ENV_PATH)/modulefiles build_suitesparse
	@cd tools_srcs/
	@sh -c "if [ -d Trilinos-trilinos-release-$(trilinos_version) ]; then \
				echo 'Trilinos src already exists';\
			else \
				wget $(trilinos_link)/trilinos-release-$(trilinos_version).tar.gz;\
				tar zxvf trilinos-release-$(trilinos_version).tar.gz;\
            fi"

.ONESHELL:
download_xyce-%: ./tools_srcs $(ENV_PATH)/modulefiles
	@cd tools_srcs/
	@sh -c "if [ -d Xyce ]; then \
				echo 'Xyce src already exists. Updating it.';\
				cd Xyce;\
				git pull;\
				git fetch --tags;\
			else \
				git clone $(xyce_link);\
				git checkout $*;\
            fi"

###############
## SuiteSparse
###############
.ONESHELL:
install_suitesparse: download_suitesparse
	@sh -c "if [ -d $(ENV_PATH)/tools/suitesparse-$(suitesparse_version) ]; then \
				echo 'SuiteSparse already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/suitesparse-$(suitesparse_version);\
				cd tools_srcs/SuiteSparse-$(suitesparse_version);\
				cp $(setup_path)/tools/xyce/build_suitesparse_modules.sh $(setup_path)/tools_srcs/SuiteSparse-$(suitesparse_version)/; \
				export CMAKE_OPTIONS='-D CMAKE_INSTALL_PREFIX=$(ENV_PATH)/tools/suitesparse-$(suitesparse_version)'; \
				./build_suitesparse_modules.sh; \
            fi"

.ONESHELL:
build_suitesparse: install_suitesparse
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=suitesparse --version=$(suitesparse_version) --bin=.  --lib=lib

###############
## Trilinos
###############
.ONESHELL:
install_trilinos-%: download_trilinos download_xyce-%
	@sh -c "if [ -d $(ENV_PATH)/tools/trilinos-$(trilinos_version) ]; then \
				echo 'Trilinos is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/trilinos-$(trilinos_version);\
                mkdir -p tools_srcs/Trilinos-trilinos-release-$(trilinos_version)/trilinos-build ;\
				cp $(setup_path)/tools/xyce/cmake_trilinos.sh tools_srcs/Trilinos-trilinos-release-$(trilinos_version)/trilinos-build;\
				cmake \
				-D CMAKE_INSTALL_PREFIX=$(ENV_PATH)/tools/trilinos-$(trilinos_version) \
				-D AMD_LIBRARY_DIRS=$(ENV_PATH)/tools/suitesparse-$(suitesparse_version)/lib \
				-D AMD_INCLUDE_DIRS=$(ENV_PATH)/tools/suitesparse-$(suitesparse_version)/include \
				-C $(setup_path)/tools_srcs/Xyce/cmake/trilinos/trilinos-base.cmake \
				..; \
				cmake --build . -j 2 -t install;\
            fi"

.ONESHELL:
build_trilinos-%: install_trilinos-%
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=trilinos --version=$(trilinos_version) --bin=.  --lib=lib


###############
## xyce
###############
.ONESHELL:
install_xyce-%: build_trilinos-%
	@sh -c "if [ -d $(ENV_PATH)/tools/Xyce-$* ]; then \
				echo 'Xyce is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/Xyce-$*;\
                cd tools_srcs/Xyce ;\
				mkdir xyce-build ;\
				cd xyce-build ;\
				cmake \
				-D CMAKE_INSTALL_PREFIX=$(ENV_PATH)/tools/Xyce-$* \
				-D Trilinos_ROOT=$(ENV_PATH)/tools/trilinos-$(trilinos_version) \
				..; \
				cmake --build . -j 2 -t install; \
            fi"

.ONESHELL:
build_xyce-%: install_xyce-%
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=Xyce --version=$* --bin=bin  --lib=lib
	@echo "module load trilinos/$(trilinos_version)" >> $(ENV_PATH)/modulefiles/Xyce/$*
	@echo "module load suitesparse/$(suitesparse_version)" >> $(ENV_PATH)/modulefiles/Xyce/$*
