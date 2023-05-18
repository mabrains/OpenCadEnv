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

netgen_link           ="https://github.com/RTimothyEdwards/netgen.git"

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
install_netgen-% : ./tools_srcs $(ENV_PATH)/modulefiles download_netgen
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