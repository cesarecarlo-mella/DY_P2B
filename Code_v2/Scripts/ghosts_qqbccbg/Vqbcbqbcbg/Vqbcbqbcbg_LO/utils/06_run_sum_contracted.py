import os
import shutil
import subprocess
import concurrent.futures 


coupl = input("vv, av, va, aa : ")
proj = input("which proj: ")
projint = int(proj)
folder_path = f"tmp/squared_contracted/{coupl}/"

files = [f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f)) and f.startswith("unreduced") and f.endswith(".ff")]
print(proj)
newfiles =  [f.replace(f'unreduced{projint}_','').replace('.ff','') for f in files]
joined = ",".join(newfiles)
print('this is the list of files I need to add together', joined)




old_pattern = "&toreplace"
old_proj = "&proj"
old_coupl = "&coupl"


# Open the file in read mode to read its content
with open('./utils/template_sum_squared_diags.frm', 'r') as file:
    content = file.read()  # Read all the content from the file

# Replace the old pattern with the new pattern
updated_content = content.replace(old_pattern, joined).replace(old_coupl,coupl).replace(old_proj, proj)


# Open the file again in write mode to overwrite it
with open('./utils/sum_squared_diags.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file

command = f'form ./utils/sum_squared_diags.frm'
subprocess.run(command, shell=True)



