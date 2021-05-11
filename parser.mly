%token <int> INTCONST
%token <string> IDENT
%token PLUS MULT DIV LPARA RPARA AND OR EQUAL
%token SEMICOLON
%token AVANCE TOOURNE BASPINCEAU HAUTPINCEAU BLOCINSTRU
%token AFFECT DEBUT FIN EOF
%start <Syntax.program> s

%left PLUS
%left MULT DIV
%{ open Syntax %}
%%

s: p = program EOF {p}

program: ds = declaration* DEBUT is = instruction* FIN {(ds, is)}

declaration: i = IDENT AFFECT t = INTCONST {(i, t)}


instruction:
    | i = IDENT AFFECT e = expression {Affectation(i, e)}
    | IF e
