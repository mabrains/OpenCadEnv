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

###############
## ngspice
###############
.ONESHELL:
download_ngspice-% : ./tools_srcs $(ENV_PATH)/modulefiles
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