import re
import os

# Directories to scan
DIRS = [
    "./tmp/squared_diagrams/vv/",
    "./tmp/squared_diagrams/av/"
]

# Regex to capture each Prop/Den product before "*gs"
product_pattern = re.compile(
    r"((?:Prop\([^)]*\)(?:\^\d+)?\s*\*?\s*)*(?:Den\([^)]*\)(?:\^\d+)?))(?=\s*\*gs)",
    re.DOTALL
)

# Find each Prop(...) or Den(...)
factor_pattern = re.compile(r"(Prop\([^)]*\)(?:\^\d+)?|Den\([^)]*\)(?:\^\d+)?)")

# Remove ^powers
def strip_power(expr):
    return re.sub(r"\^\d+", "", expr)

# Extract momentum/argument only
def extract_argument(expr):
    expr = strip_power(expr)

    # Extract inside parentheses
    inside = re.search(r"\(([^)]*)\)", expr)
    if not inside:
        return expr

    args = [a.strip() for a in inside.group(1).split(",")]

    # Prop cases
    if expr.startswith("Prop"):
        if len(args) == 1:
            return args[0]                    # Prop(momentum)
        elif len(args) >= 2:
            return args[1]                    # Prop(cut, momentum, m2, ...)
    
    # Den cases
    if expr.startswith("Den"):
        if len(args) >= 2:
            return args[1]                    # Den(cut, expr)

    return inside.group(1).strip()            # fallback

unique_results = set()

for BASE_DIR in DIRS:
    for root, dirs, files in os.walk(BASE_DIR):
        for fname in files:
            filepath = os.path.join(root, fname)

            with open(filepath, "r", errors="ignore") as f:
                text = f.read()

            matches = product_pattern.findall(text)

            for match in matches:
                factors = factor_pattern.findall(match)
                cleaned = [extract_argument(f) for f in factors]
                cleaned = [c.strip() for c in cleaned if c.strip()]

                if cleaned:
                    unique_results.add(tuple(cleaned))

            print(f"✅ Completed: {filepath}")




unique_list = list(unique_results)

with open("./tmp/den/momentum_products_unique.m", "w") as out:
    out.write("{\n")
    for i, lst in enumerate(unique_list):
        line = "  {" + ", ".join(lst) + "}"
        if i < len(unique_list) - 1:   # No trailing comma on last entry
            line += ","
        out.write(line + "\n")
    out.write("}\n")


print("\n--------------------------------------------")
print(f"✅ Extracted {len(unique_list)} unique momentum-product lists.")
print("📎 Output saved to: momentum_products_unique.m")
print("--------------------------------------------\n")
