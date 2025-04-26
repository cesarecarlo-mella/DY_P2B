import os
import shutil
import subprocess
import concurrent.futures 

if not os.path.exists("./tmp/Htensor"):
   os.makedirs("./tmp/Htensor")
   os.makedirs("./tmp/Htensor/vv")
   os.makedirs("./tmp/Htensor/aa")
   os.makedirs("./tmp/Htensor/va")
   os.makedirs("./tmp/Htensor/av")
else:
   shutil.rmtree("./tmp/Htensor")
   os.makedirs("./tmp/Htensor")
   os.makedirs("./tmp/Htensor/vv")
   os.makedirs("./tmp/Htensor/aa")
   os.makedirs("./tmp/Htensor/va")
   os.makedirs("./tmp/Htensor/av")




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




updated_content = content.replace(old_pattern, joined)
updated_content = updated_content.replace('vv', 'av')
with open('./utils/sum_squared_diags.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file
subprocess.run(command, shell=True)


updated_content = content.replace(old_pattern, joined)
updated_content = updated_content.replace('vv', 'va')
with open('./utils/sum_squared_diags.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file
subprocess.run(command, shell=True)


updated_content = content.replace(old_pattern, joined)
updated_content = updated_content.replace('vv', 'aa')
with open('./utils/sum_squared_diags.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file
subprocess.run(command, shell=True)

