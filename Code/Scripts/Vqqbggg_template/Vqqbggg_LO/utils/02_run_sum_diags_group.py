import os
import re
import shutil
import subprocess
import concurrent.futures

# --- User inputs ---
nd_file = "process_header.h"              # file containing #define NDIAG "50"
template_file = "utils/template_sum_diags.frm"  # template containing {&toreplace}
tmp_root = "tmp_folder"                   # base temporary folder
form_command = ["form", "sum_diags.frm"]  # command to run inside each subfolder

# --- Step 1: read the file and extract NDIAG ---
with open(nd_file, "r") as f:
    first_line = f.readline().strip()


def reset_folder(path):
    if os.path.exists(path):
        shutil.rmtree(path)
    os.makedirs(path, exist_ok=True)
reset_folder("./tmp/parsed_diagrams/groups")


match = re.search(r'#define\s+NDIAG\s+"(\d+)"', first_line)
if not match:
    raise ValueError(" Could not find NDIAG definition in the first line of process_header.h")

ndiag = int(match.group(1))
print(f" Found NDIAG = {ndiag}")

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
    except subprocess.CalledProcessError as e:
        print(f" FORM failed in {folder}: {e}")

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
with concurrent.futures.ThreadPoolExecutor(max_workers=n_parallel) as executor:
    executor.map(run_form_in_folder, [os.path.join(tmp_root, f"group_{i}") for i in range(1, len(groups)+1)])

print(" All jobs completed.")
shutil.rmtree("./tmp_folder")