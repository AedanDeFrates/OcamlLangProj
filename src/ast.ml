type bop = 
  | Add
  (*Subt*)
  (*Divd*)
  | Mult
  | Leq

(** [typ] represents the type of an expression. *)
type typ =
  | TInt
  (*add type for TFloat???*)
  | TBool

type expr = 
| Var of string
| Int of int
| Bool of bool
| Binop of bop * expr * expr
| Float of float
| Let of string * typ * expr * expr
| If of expr * expr * expr
