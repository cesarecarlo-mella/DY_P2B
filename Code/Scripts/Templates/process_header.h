#define NDIAG "&ndiag&"
#define NLOOP "&nloop&"
#define TYPE "&type&"
#define NPROP "&nprop&"
#define NPROJ "&nproj&"
#define PROC "&proc&"
#define NEWINTNO "&NewINTno&"
#procedure reconstruction
id INT(PL?, x1?, ..., x'NPROP'?) = INT(PL &reconstruction&,
                                    [], x1,..., x'NPROP');

id INT(PL?, n1?, ..., n'NPROP'?, [], x1?, ..., x'NPROP'?) = INT(PL, n1+...+n'NPROP', [], x1, ..., x'NPROP');
#endprocedure