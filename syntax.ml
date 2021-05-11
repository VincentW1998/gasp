type op = PLUS | MULT | DIV | EQUAL

type expression =
  | Const of int
  | Ident of string


type instruction =
  | Avance of expression
  | Tourne of expression
  | BasPinceau
  | HautPinceau
  | BlockInstru of blocInstruction

type blocInstruction = instruction

type typ = Int

type declaration = string * typ

type program = declaration list * instruction list