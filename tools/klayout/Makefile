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


klayout_link          ="https://github.com/KLayout/klayout.git"


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
install_klayout-% : ./tools_srcs $(ENV_PATH)/modulefiles download_klayout
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


