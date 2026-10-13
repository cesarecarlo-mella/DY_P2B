# Source before running the pipeline:  source Code_v2/setenv.sh
# Points FORM to Code_v2/FORMroutines (overrides FORMPATH from ~/.zshrc for this shell only).
export FORMPATH="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")" && pwd)/FORMroutines"
echo "FORMPATH=$FORMPATH"
