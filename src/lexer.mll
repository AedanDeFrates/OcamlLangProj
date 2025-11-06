{
open Parser
}

let white = [' ' '\t']+
let digit = ['0'-'9']
let int = '-'? digit+

(*regex for parsing 'float'*)
let float = '-'? digit+ '.' digit+

let letter = ['a'-'z' 'A'-'Z']
let id = letter+

rule read = 
  parse
  | white { read lexbuf }
  | "true" { TRUE }
  | "false" { FALSE }
  | "<=" { LEQ }

  (*symbol for MINUS*)
  | "-" { MINUS}
  (*symbol for DIVIDE*)
  | "/" { DIVIDE }
  
  | "*" { TIMES }
  | "+" { PLUS }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | "let" { LET }
  | "=" { EQUALS }
  | "in" { IN }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | ":" { COLON }

  (*type symbol for FLOAT_TYPE*)
  | "float" { FLOAT_TYPE }

  | "int" { INT_TYPE }
  | "bool" { BOOL_TYPE }
  | id { ID (Lexing.lexeme lexbuf) }
  | int { INT (int_of_string (Lexing.lexeme lexbuf)) }
  
  (*lexer rule for FLOAT*)
  | float { FLOAT (float_of_string (Lexing.lexeme lexbuf)) }
  | eof { EOF }