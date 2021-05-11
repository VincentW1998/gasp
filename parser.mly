%token <int> INTCONST
%token <string> IDENT
%token PLUS MOINS MULT DIV 
%token SEMICOLON EQUAL
%token AVANCE TOURNE BASPINCEAU HAUTPINCEAU 
%token DEBUT FIN EOF
%start <Syntax.program> s

%left PLUS MOINS
%left MULT DIV
%{ open Syntax %}
%%

s: p = program EOF {p}

program: ds = declaration* DEBUT is = instruction* FIN {(ds, is)}

declaration: i = IDENT EQUAL t = INTCONST {(i, t)}

instruction:
    | BASPINCEAU                       { BasPinceau }
    | HAUTPINCEAU                      { HautPinceau }
    | AVANCE            e = expression { Avance of e }
    | TOURNE            e = expression { Tourne of e }
    | i = IDENT EQUAL   e = expression { Equal (i, e) }
    | DEBUT block =  blockInstruction END { BlockInstru block }

expression:
    | s = IDENT     {Ident s}
    | n = INTCONST  {Const n}
    | e1 = expression PLUS  e2 = expression { App(e1, Plus, e2) }
    | e1 = expression MOINS e2 = expression { App(e1, Moins, e2) }
    | e1 = expression MULT  e2 = expression { App(e1, Mult, e2) }
    | e1 = expression DIV   e2 = expression { App(e1, Div, e2) }