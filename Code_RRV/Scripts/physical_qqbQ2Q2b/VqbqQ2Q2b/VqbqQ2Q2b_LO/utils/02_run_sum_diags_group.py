import glob
import os
import re
import shutil
import subprocess
import sys
import concurrent.futures

# Step 02 for one diagram set: sums the parsed diagrams of step 01 in groups.
# Run from <P>_LO/:  python3 utils/02_run_sum_diags_group.py NLOOP     (NLOOP = 1: one-loop amplitude, 0: tree)
# Asks for the group size and the number of parallel FORM jobs (stdin).
# Output: tmp/parsed_diagrams/groups/sum_<group>_<PROC>_<NLOOP>.dat. For the tree set also writes
# utils/03_complex_conj_diags.frm (the conjugate is the tree) from its template, with the number of tree groups.

nloop = int(sys.argv[1]) if len(sys.argv) > 1 else 0
nd_file = "process_header.h"              # #define NDIAG0 "..", NDIAG1 "..", PROC ".."
template_file = "utils/template_sum_diags.frm"  # template containing {&toreplace}
tmp_root = f"tmp_folder_{nloop}"          # base temporary folder (one per set)
form_command = ["form", "-d", f"NLOOP={nloop}", "sum_diags.frm"]  # command to run inside each subfolder

# --- Step 1: read NDIAG<NLOOP> and PROC ---
with open(nd_file, "r") as f:
    header = f.read()
match = re.search(rf'#define\s+NDIAG{nloop}\s+"(\d+)"', header)
if not match:
    raise ValueError(f" Could not find NDIAG{nloop} in process_header.h")
ndiag = int(match.group(1))
proc = re.search(r'#define\s+PROC\s+"(\w+)"', header).group(1)
print(f" Set NLOOP = {nloop}: NDIAG{nloop} = {ndiag}")

# old groups of this set (and, for the tree set, the conjugates made from them)
gdir = "./tmp/parsed_diagrams/groups"
os.makedirs(gdir, exist_ok=True)
old = glob.glob(os.path.join(gdir, f"sum_*_{proc}_{nloop}.dat"))
if nloop == 0:
    old += glob.glob(os.path.join(gdir, "Csum_*"))
for f in old:
    os.remove(f)

# --- Step 2: divide into groups ---

group_size = int(input("Group size? "))
if group_size == 1:
   print("in here")
   template_file = "utils/template_sum_1_diags.frm"  # template containing {&toreplace}
groups = [range(i, min(i + group_size, ndiag + 1)) for i in range(1, ndiag + 1, group_size)]

print(groups)
print(f" Dividing {ndiag} diagrams into {len(groups)} groups of up to {group_size} each.")

# --- Step 3: prepare tmp folder structure ---
if os.path.exists(tmp_root):
    shutil.rmtree(tmp_root)
os.makedirs(tmp_root)

for idx, grp in enumerate(groups, start=1):
    subfolder = os.path.join(tmp_root, f"group_{idx}")
    os.makedirs(subfolder)

    # Read and modify template for this group
    with open(template_file, "r") as f:
        template = f.read()

    numbers = "{" + ",".join(str(i) for i in grp) + "}"
    output = template.replace("{&toreplace}", numbers).replace("&group", f"{idx}")

    # Write the customized FORM file
    output_path = os.path.join(subfolder, "sum_diags.frm")
    with open(output_path, "w") as f:
        f.write(output)

if nloop == 0:
    with open("utils/template_03_complex_conj_diags.frm", "r") as f:
         tochange = f.read();
         output = tochange.replace("{&ngroups}", str(len(groups)))
    with open("utils/03_complex_conj_diags.frm", "w") as w:
         w.write(output)

print(f"📁 Created {len(groups)} group folders inside {tmp_root}/")

# --- Step 4: function to run FORM inside a subfolder ---
def run_form_in_folder(folder):
    try:
        print(f" Running FORM in {folder} ...")
        subprocess.run(form_command, cwd=folder, check=True)
        print(f" Completed {folder}")
        return True
    except subprocess.CalledProcessError as e:
        print(f" FORM failed in {folder}: {e}")
        return False

# --- Step 5: ask user how many jobs to run in parallel ---
while True:
    try:
        n_parallel = int(input(" How many jobs to run in parallel? "))
        if n_parallel > 0:
            break
    except ValueError:
        pass
    print("Please enter a positive integer.")

# --- Step 6: run FORM jobs concurrently ---
folders = [os.path.join(tmp_root, f"group_{i}") for i in range(1, len(groups)+1)]
with concurrent.futures.ThreadPoolExecutor(max_workers=n_parallel) as executor:
    ok = list(executor.map(run_form_in_folder, folders))

failed = [f for f, good in zip(folders, ok) if not good]
if failed:
    print(f" {len(failed)} FORM job(s) failed, keeping {tmp_root}/ for inspection: {failed}")
    raise SystemExit(1)

print(" All jobs completed.")
shutil.rmtree(tmp_root)
