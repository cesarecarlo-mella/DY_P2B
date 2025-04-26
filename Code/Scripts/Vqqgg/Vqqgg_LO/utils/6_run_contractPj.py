import os
import shutil
import subprocess
import concurrent.futures 

if not os.path.exists("./tmp/unreduced"):
   os.makedirs("./tmp/unreduced")
   os.makedirs("./tmp/unreduced/vv")
   os.makedirs("./tmp/unreduced/aa")
   os.makedirs("./tmp/unreduced/va")
   os.makedirs("./tmp/unreduced/av")
else:
   shutil.rmtree("./tmp/unreduced")
   os.makedirs("./tmp/unreduced")
   os.makedirs("./tmp/unreduced/vv")
   os.makedirs("./tmp/unreduced/aa")
   os.makedirs("./tmp/unreduced/va")
   os.makedirs("./tmp/unreduced/av")

proj = input("Which projector: ")


# Open the file in read mode to read its content
with open('./utils/template_contractPj.frm', 'r') as file:
    content = file.read()  # Read all the content from the file

updated_content = content
with open('./utils/contractPj.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file

command = f'form -d PROJ={proj} ./utils/contractPj.frm'
subprocess.run(command, shell=True)

updated_content = content
updated_content = updated_content.replace('vv', 'av')
with open('./utils/contractPj.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file
subprocess.run(command, shell=True)

updated_content = content
updated_content = updated_content.replace('vv', 'va')
with open('./utils/contractPj.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file
subprocess.run(command, shell=True)

updated_content = content
updated_content = updated_content.replace('vv', 'aa')
with open('./utils/contractPj.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file
subprocess.run(command, shell=True)

