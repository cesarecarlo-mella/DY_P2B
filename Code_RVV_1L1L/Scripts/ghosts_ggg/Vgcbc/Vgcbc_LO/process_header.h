#define NDIAG0 "0"
#define NDIAG1 "2"
#define PROC "Vgcbc"
* two diagram sets: NLOOP = 1 one-loop amplitude, NLOOP = 0 tree (conjugate); NLOOP from the command line
#ifndef `NLOOP'
#define NLOOP "0"
#endif
#define NDIAG "`NDIAG`NLOOP''"
