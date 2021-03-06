type op = Plus | Moins| Mult| Div

type expression =
  | Const of int
  | Ident of string
  | App of expression * op * expression

type instruction =
  | BasPinceau
  | HautPinceau
  | Avance        of expression
  | Tourne        of expression
  | BlocInstru    of instruction list
  | Equal         of string * expression
  | TantFaire     of expression * instruction
  | IfAlorsSinon  of expression * instruction * instruction 
  | ChangeColor   of int
  | ChangeWidth   of expression

type declaration = Var of string

type program = (declaration list) * instruction 