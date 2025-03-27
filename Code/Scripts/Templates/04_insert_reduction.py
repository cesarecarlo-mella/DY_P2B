from common import *
from pynman.form_helpers import *
import logging
setup_logger(DEBUG=True, start_new_log=False)
logging.info(
    f"Executing script 04_insert_reduction.py for {process} {axialtype} at {NLoops} loops.")

# simplify_reduction('external/reduction.inc', 'external/reduction_processed.inc')

# find mapping from crossed families to integer codes
mapping = families_to_int_mapping()

# insert mapping into reduction file
substitutions_in_reduction(mapping, infile=reduction_file,
                           outfile="external/reduction_processed.inc", kira=False)

# insert mapping into amplitude files
substitutions_in_amplitude(mapping, folder='ampl')

# create tablebase with reductions
run_create_table(reduction_file="external/reduction_processed.inc")

# insert reduction into amplitude files
insert_reduction(mapping, folder='ampl')
