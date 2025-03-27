from socket import gethostname
from pynman.colour_database import *

# process info
process = '&proc&'
NLoops = &nloop&
NCores = &ncores&
tformcores = 2
#NExt = ''
NProp = int(NLoops*(NLoops+1)/2+NExt*NLoops)
if NLoops == 0:
    NProp = 1


# executables
if gethostname() in ['MacBook-Pro-di-Cesare.local', 'MBP-di-Cesare']:
    qgrafpath = '/Applications/qgraf-3.4.2/qgraf'
    tformpath = f"tform -w{tformcores}"
    mathpath = 'MathKernel'
elif gethostname() in ["newton1.t30.ph.tum.de", "newton2.t30.ph.tum.de"]:
    qgrafpath = '/home/t30/all/ge45tuy/Software/qgraf-3.4.2/qgraf'
    tformpath = f"tform -w{tformcores}"
    mathpath = 'MathKernel'
else:
    raise Exception(
        "Unknown OS - maybe you need to add the name of your computer to line 13 of Scripts/Templates/common.py")

# filenames - in a future implementation, either all paths will be hardcoded
# or all should be taken from this list (currently a mix)
qgraftemplate = '../../../QGRAF/template.dat'
drawerinput = 'external/&proc&.&nloop&.txt'
draweroutput = 'drawings'
forminput = 'external/&proc&.&nloop&.inc'
formcolour_outfile = 'tmp/colour_out.&nloop&.dat'
mom2words_outfile = 'tmp/mom2words_out.&nloop&.inc'
part2_outfile = 'tmp/part2_out.&nloop&.dat'
toReduce_outfile = 'external/toReduce.&nloop&.inc'
sector_splitting_script = 'utils/extract_sectors.sh'
#form_factor_script = '05_parallel_run_form_factor.sh'
reduction_file = 'external/reduction.inc'
FFints_outfile = 'external/toShift.1.inc'
zerosdir = 'tmp/zeros/zeros.inc'
reduze_diagram_shifts = 'external/&proc&.&nloop&.shifts.inc'
table_file="external/reduction_table.tbl"
local_reduction_file = 'external/reduction_local.inc' 

# options
qgrafinputs = {'process': '&proc&', 'Nloops': '&nloop&',
               'output': 'custom'}
diags_to_draw = [1]

# integral families
#all_fams = {0: {'TREE': []},
#            1: {'PL': ["k1", "k1-p1", "k1-p1-p2", "k1-p1-p2-p3"]},
#            2: {'PL': ["k1", "k2", "k1-k2", "k1-p1", "k2-p1", "k1-p1-p2", "k2-p1-p2", "k1-p1-p2-p3", "k2-p1-p2-p3"],
#                'NPL': ["k1", "k2", "k1-p1", "k2-p1", "k1+p3", "k2+p3", "k1+p2+p3", "k1-k2", "k1-k2+p2"]},
#            3: {"PL": ["k1", "k2", "k3", "k1-p1", "k2-p1", "k3-p1", "k1-p1-p2", "k2-p1-p2", "k3-p1-p2", "k1-p1-p2-p3", "k2-p1-p2-p3", "k3-p1-p2-p3", "k1-k2", "k1-k3", "k2-k3"],
#                "NPL1": ["k1", "k2", "k3", "k1-p1", "k2-p1", "k3-p1", "k1-p1-p2", "k2-p1-p2", "k3-p1-p2", "k1-p1-p2-p3", "k2-p1-p2-p3", "k3-p1-p2-p3", "k1-k2", "k2-k3", "k1-k2+k3"],
#                "NPL1c34": ["k1", "k2", "k3", "k1-p1", "k2-p1", "k3-p1", "k1-p1-p2", "k2-p1-p2", "k3-p1-p2", "k1+p3", "k2+p3", "k3+p3", "k1-k2", "k2-k3", "k1-k2+k3"],
#                "NPL2": ["k1", "k2", "k3", "k1-p1", "k2-p1", "k3-p1", "k1-p1-p2", "k3-p1-p2", "k1-k2", "k2-k3", "k1-k2-p3", "k2-k3+p1+p2+p3", "k2+p3", "k1-k3", "k2-p1-p2"],
#                "NPL2c24": ["k1", "k2", "k3", "k1-p1", "k2-p1", "k3-p1", "k1+p2+p3", "k3+p2+p3", "k1-k2", "k2-k3", "k1-k2-p3", "k2-k3-p2", "k2+p3", "k1-k3", "k2+p2+p3"]}}
#intfams = all_fams[NLoops]

# permutations
permutations = {'': 'ABC',
                'x12': 'BAC',
                'x13': 'CBA',
                'x23': 'ACB',
                'x123': 'BCA',
                'x132': 'CAB'}


NProj = proj_nums[process]

# colour layers
colour_layers = colour_database[process][NLoops]
