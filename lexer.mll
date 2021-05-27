{
    open Lexing
    open Parser
    exception Error of string

    let keyword_table = Hashtbl.create 19;;
    List.iter (fun (kwd, tok) -> Hashtbl.add keyword_table kwd tok)
                [ ("Var", VAR);
                  ("Avance", AVANCE);
                  ("Tourne", TOURNE);
                  ("BasPinceau", BASPINCEAU);
                  ("HautPinceau", HAUTPINCEAU);
                  ("Debut", DEBUT);
                  ("Fin", FIN);
                  ("If", IF); 
                  ("Alors", ALORS); (* executer si expression != 0 *)
                  ("Sinon", SINON); 
                  ("Tant", TANT); (* s'arrete si expression == 0 *)
                  ("Faire", FAIRE);
                  ("ChangeCouleur", CHANGECOLOR);
                  ("ChangeEpaisseur", CHANGEWIDTH);
                  ("noir", NOIR);
                  ("rouge", ROUGE);
                  ("bleu", BLEU);
                  ("vert", VERT);
                  ("jaune", JAUNE) ]

    let next_line lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_bol = lexbuf.lex_curr_pos;
                 pos_lnum = pos.pos_lnum + 1
      }
}

let letter = ['A'-'Z' 'a'-'z']
let digit = ['0'-'9']

rule token = parse
    | [' ''\t']       { token lexbuf }
    | '\n'            { next_line lexbuf; token lexbuf }
    | letter (letter | digit)* as id
        { try Hashtbl.find keyword_table id
          with Not_found -> IDENT id }
    | '='                   { EQUAL }
    | '+'                   { PLUS }
    | '-'                   { MOINS }
    | '*'                   { MULT }
    | '/'                   { DIV }
    | ';'                   { SEMICOLON }
    | digit+                { INTCONST(int_of_string(Lexing.lexeme lexbuf)) }
    | letter(letter|digit)* { IDENT(Lexing.lexeme lexbuf) }
    | eof                   { EOF }
    | _                     { raise (Error (Lexing.lexeme lexbuf)) }