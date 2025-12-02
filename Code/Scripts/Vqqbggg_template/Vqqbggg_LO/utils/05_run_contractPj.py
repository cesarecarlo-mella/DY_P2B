import os
import shutil
import subprocess
import concurrent.futures 

if not os.path.exists("./tmp/squared_contracted"):
   os.makedirs("./tmp/squared_contracted")
   os.makedirs("./tmp/squared_contracted/vv")
   os.makedirs("./tmp/squared_contracted/aa")
   os.makedirs("./tmp/squared_contracted/va")
   os.makedirs("./tmp/squared_contracted/av")


proj = input("Which projector: ")
n_workers = int(input("How many parallel jobs: "))


# Open the file in read mode to read its content
with open('./utils/template_contractPj.frm', 'r') as file:
    template_content = file.read()  # Read all the content from the file


# Need to update with option for calling aa av va, remember to change also content of form template job




folder_path = "tmp/squared_diagrams/vv/"
files = [f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))]
newfiles = [f.replace('vv_', '').replace('.inc', '') for f in files]
print("Will process:", ", ".join(newfiles))




def run_form(which_value):

    # Create subfolder for this job
    job_folder = f"./utils/job_{which_value}"
    if os.path.exists(job_folder):
        shutil.rmtree(job_folder)
    os.makedirs(job_folder)

    # Write a job-specific FORM file into the subfolder
    form_file_path = os.path.join(job_folder, "contractPj.frm")
    with open(form_file_path, 'w') as fw:
        fw.write(template_content)

    # Build command
    form_file_path = os.path.join(f"./job_{which_value}",  "contractPj.frm")
    command = f'form -d PROJ={proj} -d WHICH={which_value} "contractPj.frm"'


    print(f"[JOB {which_value}] Starting…")
    result = subprocess.run(command, shell=True, cwd=job_folder)
    
    try:
        shutil.rmtree(job_folder)
        print(f"[JOB {which_value}] Cleaned up folder.")
    except Exception as e:
        print(f"[JOB {which_value}] Warning: could not remove folder ({e}).")

    if result.returncode == 0:
        print(f"[JOB {which_value}] Finished successfully.")
    else:
        print(f"[JOB {which_value}] FAILED with return code {result.returncode}.")

    return which_value, result.returncode

# -----------------------------------------
# Run jobs in parallel
# -----------------------------------------
failed_jobs = []


#run_form('8_25')


with concurrent.futures.ProcessPoolExecutor(max_workers=n_workers) as executor:
    for which_value, returncode in executor.map(run_form, newfiles):
        if returncode != 0:
            failed_jobs.append(which_value)


if failed_jobs:
    with open("failed_jobs.txt", "w") as f:
        for job in failed_jobs:
            f.write(job + "\n")
    print(f"Saved failed jobs to failed_jobs.txt")
else:
    print("No job failed.")





