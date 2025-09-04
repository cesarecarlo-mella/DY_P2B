import os
import shutil
import subprocess
import concurrent.futures

base_dir = "./tmp/Htensor"
subdirs = ["av","aV", "Av", "AV", "va","vA", "Va", "VA", "vv","vV", "Vv", "VV", "aa", "aA", "Aa", "AA"]


# remove existing directory
if os.path.exists(base_dir):
    shutil.rmtree(base_dir)

# create base and subdirectories
os.makedirs(base_dir)
for sd in subdirs:
    os.makedirs(os.path.join(base_dir, sd))




folder_path = "tmp/squared_diagrams/vv/"

files = [f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))]
newfiles =  [f.replace('vv_diag_','').replace('.inc','') for f in files]
joined = ",".join(newfiles)
print(joined)


old_pattern = "&toreplace"

# Open the file in read mode to read its content
with open('./utils/template_sum_squared_diags.frm', 'r') as file:
    content = file.read()  # Read all the content from the file

# Replace the old pattern with the new pattern
updated_content = content.replace(old_pattern, joined)

# Open the file again in write mode to overwrite it
with open('./utils/sum_squared_diags.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file

command = f'form ./utils/sum_squared_diags.frm'
subprocess.run(command, shell=True)


base_pattern = "vv"
replacements = ["av","aV", "Av", "AV", "va","vA", "Va", "VA", "vV", "Vv", "VV", "aa", "aA", "Aa", "AA"]

for repl in replacements:
    updated_content = content.replace(old_pattern, joined)
    updated_content = updated_content.replace(base_pattern, repl)
    with open('./utils/sum_squared_diags.frm', 'w') as file:
        file.write(updated_content)  # Write the modified content back into the file
    subprocess.run(command, shell=True)
    