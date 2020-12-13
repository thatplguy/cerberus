%token <int> NUM
%token <string> ID
%token <string> PID
%token TRUE FALSE
%token AT DOT STAR AMPERSAND
%token POINTER_TO_INTEGER INTEGER_TO_POINTER
%token LPAREN RPAREN
%token COMMA
%token PLUS MINUS DIV
%token LT GT LE GE NE EQEQ
%token MIN MAX
/* %token CHAR SHORT INT LONG SIGNED UNSIGNED */
%token OWNED BLOCK /* UNOWNED */
%token EOF

/* stealing from Core parser */
%token SHORT INT LONG LONG_LONG BOOL SIGNED UNSIGNED 
/* %token FLOAT DOUBLE LONG_DOUBLE */
%token CHAR ICHAR 
/* %token VOID */
%token INT8_T INT16_T INT32_T INT64_T UINT8_T UINT16_T UINT32_T UINT64_T
%token INTPTR_T INTMAX_T UINTPTR_T UINTMAX_T SIZE_T PTRDIFF_T
/* %token ATOMIC STRUCT (* TODO *)  */
/* %token UNION (* TODO *)  */
/* %token ENUM (* TODO *) WCHAR_T (* TODO *) CHAR16_T (* TODO *) CHAR32_T (* TODO *) */
/* %token LBRACKET RBRACKET */


%left LT GT LE GE EQEQ NE
%left PLUS MINUS
%left DIV
%right INTEGER_TO_POINTER POINTER_TO_INTEGER
%right STAR


%%