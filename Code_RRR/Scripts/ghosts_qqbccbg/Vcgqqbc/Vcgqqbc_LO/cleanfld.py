import os

folders = [
    "tmp/squared_diagrams/",
    "tmp/squared_contracted/",
    "tmp/unreduced/",
    "tmp/Htensor/"
]

for root_folder in folders:
    if not os.path.exists(root_folder):
        print(f"[SKIP] Folder does not exist: {root_folder}")
        continue

    print(f"[CLEAN] Processing: {root_folder}")

    for dirpath, dirnames, filenames in os.walk(root_folder):
        for f in filenames:
            file_path = os.path.join(dirpath, f)
            try:
                os.remove(file_path)
                print(f"  Deleted: {file_path}")
            except Exception as e:
                print(f"  Could not delete {file_path}: {e}")

print("Cleanup complete.")
