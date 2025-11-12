%{
open Ast
%}
//Define FLOAT token
%token <float> FLOAT

%token <int> INT
%token <string> ID
%token TRUE
%token FALSE
%token LEQ

// Token for GEQ


//Add Token for MINUS
%token MINUS

//Add Token for DIVIDE
%token DIVIDE

%token TIMES
%token PLUS

//Add Float Operation Tokens
%token FMINUS
%token FDIVIDE
%token FTIMES
%token FPLUS

%token LPAREN
%token RPAREN
%token LET
%token EQUALS
%token IN
%token IF
%token THEN
%token ELSE
%token COLON

//Add Token for FLOAT_TYPE data type
%token FLOAT_TYPE

%token INT_TYPE
%token BOOL_TYPE
%token EOF

%nonassoc IN
%nonassoc ELSE

//Precedence Declarations

//Add precedence for GEQ
%left LEQ 

//Add precendence for MINUS
%left PLUS MINUS
//Add precendence for DIVIDE
%left TIMES DIVIDE

//Add precedence for Float Operations
%left FPLUS FMINUS
%left FTIMES FDIVIDE


%start <Ast.expr> prog

%%

prog:
	| e = expr; EOF { e }
	;
	
expr:
	| i = INT { Int i }
	//expr parser for FLOAT
	| f = FLOAT { Float f }
  	| x = ID { Var x }
  	| TRUE { Bool true }
  	| FALSE { Bool false }

	//implement expression handler for GEQ
  	| e1 = expr; LEQ; e2 = expr { Binop (Leq, e1, e2) }
  	| e1 = expr; TIMES; e2 = expr { Binop (Mult, e1, e2) }
  	| e1 = expr; PLUS; e2 = expr { Binop (Add, e1, e2) }

	//implement expression handler for Subtraction
	| e1 = expr; MINUS; e2 = expr { Binop (Subtr, e1, e2)}
	//implement expression handler for Division
	| e1 = expr; DIVIDE; e2 = expr { Binop (Divd, e1, e2)}

	//implement expression handlers for Float operations
	| e1 = expr; FTIMES; e2 = expr { Binop (FMult, e1, e2) }
	| e1 = expr; FPLUS; e2 = expr { Binop (FAdd, e1, e2) }
	| e1 = expr; FMINUS; e2 = expr { Binop (FSubtr, e1, e2) }
	| e1 = expr; FDIVIDE; e2 = expr { Binop (FDivd, e1, e2) }

  	| LET; x = ID; COLON; t = typ; EQUALS; e1 = expr; IN; e2 = expr 
		{ Let (x, t, e1, e2) }
  	| IF; e1 = expr; THEN; e2 = expr; ELSE; e3 = expr { If (e1, e2, e3) }
  	| LPAREN; e=expr; RPAREN {e}
	;

typ: 
	| INT_TYPE { TInt }
	| BOOL_TYPE { TBool }
	//Add parsing rule for FLOAT_TYPE
	| FLOAT_TYPE { TFloat }
	;