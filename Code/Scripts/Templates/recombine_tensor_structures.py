from common import *
from pynman.form_helpers import *
import logging
setup_logger(DEBUG=True, start_new_log=False)
logging.info(
    f"Executing script recombine_tensor_structures.py for {process} {axialtype} at {NLoops} loops.")

run_recombination(origin='ampl', destination='ampl_recombined',
                  layers=None, filename='S1_reduced_FORM.ff', polyratfun=True)
