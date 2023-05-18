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
SOURCES          := $(shell find ${setup_path}/tools -name 'Makefile')

include ${SOURCES}

# ==== MAKE TARGETS =====
./tools_srcs:
	@mkdir -p  tools_srcs

$(ENV_PATH)/modulefiles:
	@mkdir -p  $(ENV_PATH)/modulefiles

$(PDK_ROOT):
	@mkdir -p  $(PDK_ROOT)

# =========================================================================================== 
# --------------------------- Checks and Layout Tools Installation --------------------------
# ===========================================================================================
echo_sources:
	echo ${SOURCES}

# =========================================================================================== 
# ---------------------------------------- CLEAN SRCS ---------------------------------------
# ===========================================================================================

clean_builds:
	rm -rf tools_srcs
