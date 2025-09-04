import os
import shutil
import subprocess
import concurrent.futures 



base_dir = "./tmp/unreduced"
subdirs = ["av","aV", "Av", "AV", "va","vA", "Va", "VA", "vv","vV", "Vv", "VV", "aa", "aA", "Aa", "AA"]

# remove existing directory
#if os.path.exists(base_dir):
#    shutil.rmtree(base_dir)

# create base and subdirectories
#os.makedirs(base_dir)
#for sd in subdirs:
#    os.makedirs(os.path.join(base_dir, sd))

proj = input("Which projector: ")


# Open the file in read mode to read its content
with open('./utils/template_contractPj.frm', 'r') as file:
    content = file.read()  # Read all the content from the file

updated_content = content
with open('./utils/contractPj.frm', 'w') as file:
    file.write(updated_content)  # Write the modified content back into the file

command = f'form -d PROJ={proj} ./utils/contractPj.frm'
subprocess.run(command, shell=True)


base_pattern = "vv"
replacements = ["av","aV", "Av", "AV", "va","vA", "Va", "VA", "vV", "Vv", "VV", "aa", "aA", "Aa", "AA"]
#replacements = ["aV"]



for repl in replacements:
    print(repl)
    updated_content = content
    updated_content = updated_content.replace(base_pattern, repl)
    with open('./utils/contractPj.frm', 'w') as file:
        file.write(updated_content)  # Write the modified content back into the file
    subprocess.run(command, shell=True)


