import glob
import os
import shutil
import subprocess
import concurrent.futures 

if not os.path.exists("./tmp/squared_diagrams"):
   os.makedirs("./tmp/squared_diagrams")
   os.makedirs("./tmp/squared_diagrams/vv")
   os.makedirs("./tmp/squared_diagrams/aa")
   os.makedirs("./tmp/squared_diagrams/va")
   os.makedirs("./tmp/squared_diagrams/av")
else:
   shutil.rmtree("./tmp/squared_diagrams")
   os.makedirs("./tmp/squared_diagrams")
   os.makedirs("./tmp/squared_diagrams/vv")
   os.makedirs("./tmp/squared_diagrams/aa")
   os.makedirs("./tmp/squared_diagrams/va")
   os.makedirs("./tmp/squared_diagrams/av")


onlyvector = int(input("type 0 for full calculation, type > 0 for only vector "))
lc = int(input("type 0 for full color calculation, type > 0 for lc "))

def run_form(i, j):
    folder = f"./tmp_{i}_{j}"
    os.mkdir(folder)
    shutil.copy("../4_square_ampl.frm", f"{folder}/4_square_ampl.frm")
    command = f'form -d LC={lc} -d ONLYVECTOR={onlyvector} -d loopind={i} -d loopind2={j} 4_square_ampl.frm'
    os.chdir(folder)
    os.system(command)
    os.chdir("../")
    shutil.rmtree(folder)

mw = int(input("Enter the max number of parallel jobs: "))



# Directory containing your parsed diagrams
parsed_dir = "./tmp/parsed_diagrams/groups/"

# Count all files starting with "sum_1_"
# Count sum_1_* files
# Count diagrams
ndiag1 = len(glob.glob(os.path.join(parsed_dir, "sum_*")))
ndiag2 = len(glob.glob(os.path.join(parsed_dir, "Csum_*")))

print("Number of diagrams for amp1:", ndiag1)
print("Number of diagrams for amp2:", ndiag2)

# All possible runs
all_runs = [(i, j) for i in range(1, ndiag1 + 1)
                     for j in range(1, ndiag2 + 1)]

print("\nAvailable runs:")
for k, (i, j) in enumerate(all_runs, start=1):
    print(f"{k}: (i={i}, j={j})")

# Simple choice
print("\nChoose run mode:")
print("  a = run all")
print("  o = run one specific (by index)")

mode = input("Selection: ").strip().lower()

if mode == "a":
    selected_runs = all_runs

elif mode == "o":
    idx = int(input("Enter the index of the run to execute: ").strip())
    selected_runs = [all_runs[idx - 1]]

else:
    raise ValueError("Invalid selection")

print("\nRuns selected:")
print(selected_runs)

# Prepare tmp directory
tmpdir = "./utils/tmp_fld"
if os.path.exists(tmpdir):
    shutil.rmtree(tmpdir)
os.mkdir(tmpdir)

os.chdir(tmpdir)

# Execute jobs
with concurrent.futures.ProcessPoolExecutor(max_workers=mw) as executor:
    futures = [executor.submit(run_form, i, j) for (i, j) in selected_runs]
    concurrent.futures.wait(futures)

os.chdir("../../")
shutil.rmtree(tmpdir)

print("\nDone.")