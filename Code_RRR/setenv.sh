# Source before running the pipeline:  source Code_RRR/setenv.sh   (bash or zsh, macOS or Linux)
# Points FORM to Code_RRR/FORMroutines (overrides FORMPATH from ~/.zshrc / ~/.bashrc for this shell only).
# Other shells (e.g. sh = dash): run it from inside Code_RRR:  cd Code_RRR && . ./setenv.sh
if [ -n "$BASH_VERSION" ]; then
  _setenv_dir=$(eval 'dirname "${BASH_SOURCE[0]}"')
elif [ -n "$ZSH_VERSION" ]; then
  _setenv_dir=$(eval 'dirname "${(%):-%x}"')
else
  _setenv_dir=.
  echo "setenv.sh: not bash/zsh, assuming the current directory is Code_RRR"
fi
export FORMPATH="$(cd "$_setenv_dir" && pwd)/FORMroutines"
unset _setenv_dir
[ -f "$FORMPATH/all_header.h" ] || echo "setenv.sh: warning, $FORMPATH/all_header.h not found"
echo "FORMPATH=$FORMPATH"
