from common import *
from pynman.booboo import *
from pynman.form_helpers import *
import logging
setup_logger(DEBUG=True, start_new_log=False)
logging.info(
    f"Executing script 03_sum_sectors.py for {process} {axialtype} at {NLoops} loops.")

# reformat shifts
#reformat_shifts(infile='external/shifted.inc',
#                outfile='external/shifted_reformatted.inc', add_sorts=True)

# run all sectors
sum_sectors(layers=None, shift=False,
            shiftfile='external/shifted_reformatted.inc', polyratfun=True, delete_temporary_files=False)
