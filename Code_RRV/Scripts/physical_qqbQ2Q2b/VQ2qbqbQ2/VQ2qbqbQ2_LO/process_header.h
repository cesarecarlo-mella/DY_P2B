#define NDIAG0 "4"
#define NDIAG1 "56"
#define PROC "VQ2qbqbQ2"
* two diagram sets: NLOOP = 1 one-loop amplitude, NLOOP = 0 tree (conjugate); NLOOP from the command line
#ifndef `NLOOP'
#define NLOOP "0"
#endif
#define NDIAG "`NDIAG`NLOOP''"
