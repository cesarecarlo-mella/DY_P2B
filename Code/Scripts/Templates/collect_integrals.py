from common import *
from pynman.form_helpers import *
import logging
setup_logger(DEBUG=True, start_new_log=False)
logging.info(
    f"Executing script collect_integrals.py for {process} {axialtype} at {NLoops} loops.")

# run_collect_integrals('form_factors', FFints_outfile, layers=None)
run_collect_integrals('ampl', toReduce_outfile, layers=None)
