type bop = 
  | Add
  (*Subtr*)
  | Subtr
  (*Divd*)
  | Divd
  | Mult

  (*bop for Floats*)
  | FAdd
  | FSubtr
  | FDivd
  | FMult
  
  | Leq

(** [typ] represents the type of an expression. *)
type typ =
  | TInt
  (*add type for TFloat*)
  | TFloat
  | TBool

  type expr = 
| Var of string
| Int of int
| Bool of bool
| Binop of bop * expr * expr
| Float of float
| Let of string * typ * expr * expr
| If of expr * expr * expr
