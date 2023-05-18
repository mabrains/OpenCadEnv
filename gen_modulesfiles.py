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

"""
Run Modulefiles generator.

Usage:
    gen_modulefiles.py (--help| -h)
    gen_modulefiles.py (--path=<env_path>) (--name=<tool_name>) (--version=<tool_version>) [--bin=<tool_bin>] [--lib=<tool_lib>]

Options:
    --help -h                   Print this help message.
    --path=<env_path>           Path of your installations environment.
    --name=<tool_name>          The name of installed tool.
    --version=<tool_version>    The version of installed tool.
    --bin=<tool_bin>            The version of installed tool.
    --lib=<tool_lib>            The version of installed tool.
"""

from docopt import docopt
from jinja2 import Template
import logging
import os


def main ():
    
    ENV_PATH = arguments["--path"]
    TOOL     = arguments["--name"]
    VERSION  = arguments["--version"]
    TOOL_BIN = arguments["--bin"] if arguments["--bin"] else "bin"
    TOOL_LIB = arguments["--lib"] if arguments["--lib"] else "lib"

    gen_path = os.path.dirname(os.path.abspath(__file__))
    if "pythonlibs" in TOOL:
        module_tmp = f"{gen_path}/pythonlibs_template.jn"
    else:
        module_tmp = f"{gen_path}/module_template.jn"

    with open(module_tmp) as f:
        tmpl = Template(f.read())
        os.makedirs(f"{ENV_PATH}/modulefiles/{TOOL}",exist_ok=True)
        with open(f"{ENV_PATH}/modulefiles/{TOOL}/{VERSION}", "w") as module:
            module.write(tmpl.render(ENV_PATH =ENV_PATH, TOOL =TOOL, VERSION= VERSION, TOOL_BIN= TOOL_BIN, TOOL_LIB= TOOL_LIB))


if __name__ == "__main__":

    ## Logs format
    logging.basicConfig(level=logging.DEBUG, format=f"%(asctime)s | %(levelname)-7s | %(message)s", datefmt='%d-%b-%Y %H:%M:%S')

    # arguments
    arguments     = docopt(__doc__)

    # Calling main function
    main()    