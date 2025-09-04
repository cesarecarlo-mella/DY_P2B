import os
import shutil
import subprocess
import concurrent.futures 


base_dir = "./tmp/squared_diagrams"
subdirs = ["av","aV", "Av", "AV", "va","vA", "Va", "VA", "vv","vV", "Vv", "VV", "aa", "aA", "Aa", "AA"]

# remove existing directory
if os.path.exists(base_dir):
    shutil.rmtree(base_dir)

# create base and subdirectories
os.makedirs(base_dir)
for sd in subdirs:
    os.makedirs(os.path.join(base_dir, sd))


def run_form(i, j):
    folder = f"./tmp_{i}_{j}"
    os.mkdir(folder)
    shutil.copy("../3_square_ampl.frm", f"{folder}/3_square_ampl.frm")
    command = f'form -d loopind={i} -d loopind2={j} 3_square_ampl.frm'
    os.chdir(folder)
    os.system(command)
    os.chdir("../")
    shutil.rmtree(folder)

mw = int(input("Enter the max number of parallel jobs: "))





with open("./process_header.h", "r") as file:
    line = file.readline().strip()  # Read first line and remove extra spaces/newlines
    ndiag1=int((line.split(" ")[2]).split("\"")[1])

with open("./process_header.h", "r") as file:
    line = file.readline().strip()  # Read first line and remove extra spaces/newlines
    ndiag2=int((line.split(" ")[2]).split("\"")[1])



print("Number of diagram of amp1 is", ndiag1)
print("Number of diagram of amp2 is", ndiag2)


if os.path.exists("./utils/tmp_fld"):  # Check if folder exists
    shutil.rmtree("./utils/tmp_fld")  # Removes folder
    os.mkdir("./utils/tmp_fld")  # Create folder
else:
    os.mkdir("./utils/tmp_fld") 

os.chdir("./utils/tmp_fld/")

with concurrent.futures.ProcessPoolExecutor(max_workers=mw) as executor:
        futures = [executor.submit(run_form, i, j) for i in range(1, ndiag1+1) for j in range(1, ndiag2+1)]
        concurrent.futures.wait(futures)
#with concurrent.futures.ProcessPoolExecutor(max_workers=mw) as executor:
#        futures = [executor.submit(run_form, i, j) for i in [1] for j in [3]]
#        concurrent.futures.wait(futures)

os.chdir("../../")
shutil.rmtree("./utils/tmp_fld")



