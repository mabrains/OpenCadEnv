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


# xschem-gaw_link       ="https://github.com/StefanSchippers/xschem-gaw.git"
xschem_link           ="https://github.com/StefanSchippers/xschem.git"
xschem_version        =dev

###############
## xschem
###############
# .ONESHELL:
# download_gaw3: ./tools_srcs $(ENV_PATH)/modulefiles
# 	@cd tools_srcs/
# 	@sh -c "if [ -d xschem-gaw ]; then \
# 				echo 'xschem-gaw src is already exist. Updating folder.';\
# 				cd xschem-gaw;\
# 				git pull;\
# 				git fetch --tags;\
# 			else \
# 				git clone $(xschem-gaw_link);\
#             fi"

# .ONESHELL:
# install_gaw3: download_gaw3
# 	@sh -c "if [ -d $(ENV_PATH)/tools/xschem-gaw ]; then \
# 				echo 'xschem-gaw is already installed';\
# 			else \
# 				mkdir -p  $(ENV_PATH)/tools/xschem-gaw;\
#                 cd tools_srcs/xschem-gaw ;\
# 				autoreconf -i;\
# 				./configure prefix=$(ENV_PATH)/tools/xschem-gaw;\
# 				make -j$$(nproc);\
# 				make install;\
#             fi"

# .ONESHELL:
# build_gaw3: install_gaw3
# 	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=xschem-gaw --version=head --bin=bin  --lib=lib

.ONESHELL:
download_xschem: ./tools_srcs $(ENV_PATH)/modulefiles
	@cd tools_srcs/
	@sh -c "if [ -d xschem ]; then \
				echo 'xschem src is already exist';\
				cd xschem;\
				git pull;\
				git fetch --tags;\
			else \
				git clone $(xschem_link);\
            fi"

.ONESHELL:
install_xschem: download_xschem
	@sh -c "if [ -d $(ENV_PATH)/tools/xschem-$(xschem_version) ]; then \
				echo 'xschem is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/xschem-$(xschem_version);\
			fi;\
			cd tools_srcs/xschem ;\
			./configure prefix=$(ENV_PATH)/tools/xschem-$(xschem_version);\
			make -j$$(nproc);\
			make install;"

.ONESHELL:
build_xschem: install_xschem
	@/usr/bin/python3 $(setup_path)/gen_modulesfiles.py --path=$(ENV_PATH) --name=xschem --version=$(xschem_version) --bin=bin  --lib=.