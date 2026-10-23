#define NDIAG0 "2"
#define NDIAG2 "229"
#define PROC "Vgqbqb"
* two diagram sets: NLOOP = 2 two-loop amplitude, NLOOP = 0 tree (conjugate); NLOOP from the command line
#ifndef `NLOOP'
#define NLOOP "0"
#endif
#define NDIAG "`NDIAG`NLOOP''"
