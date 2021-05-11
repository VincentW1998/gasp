type op = PLUS | MOINS | MULT | DIV 

type expression =
  | Const of int
  | Ident of string
  | App of expression * op * expression

type instruction =
  | BasPinceau
  | HautPinceau
  | Avance      of expression
  | Tourne      of expression
  | BlocInstru  of blocInstruction
  | Equal       of string * epxression

type blocInstruction = 
  | Instru of instruction 
  | BlocInstru of blocInstruction

type declaration = string * int

type program = declaration list * instruction list