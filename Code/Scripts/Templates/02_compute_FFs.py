from common import *
from pynman.form_helpers import *
import logging
setup_logger(DEBUG=True, start_new_log=False)
logging.info(
    f"Executing script 02_compute_FFs.py for {process} {axialtype} at {NLoops} loops.")

# run everything
run_FF()

# run evrything in specific colour layers
# run_FF(layers=['C0F0Z0', 'C9F1Z0'])

# run specific sectors in specfic layers
# run_FF(sectors=[('C0F0Z0', 'NPL', 'NPL_39'), ('C9F1Z0', 'PLx12', 'PLx12_147')])
