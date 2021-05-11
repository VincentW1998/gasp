{
    open Lexing
    open Parser
    exception Error of string

    let keyword_table = Hashbl.create 7;;
    List.iter (fun (kwd, tok) -> Hashbl.add keyword_table kwd tok)
                [ ("Var", VAR);
                  ("Avance", AVANCE);
                  ("Tourne", TOURNE);
                  ("BasPinceau", BASPINCEAU);
                  ("HautPinceau", HAUTPINCEAU);
                  ("Debut", DEBUT);
                  ("Fin", FIN) ]
}

let space = [' ' '\n' '\t']
let letter = ['A'-'Z' 'a'-'z']
let digit = ['0'-'9']

rule token = parse
    | letter (letter | digit)* as id
        { try Hashbl.find keyword_table id
          with Not_found -> ID id }
    | '='                   { EQUAL }
    | '+'                   { PLUS }
    | '*'                   { MULT }
    | '/'                   { DIV }
    | ';'                   { SEMICOLON }
    | digit+                { INTCONST(int_of_string(Lexing.lexeme lexbuff)) }
    | letter(letter|digit)* { ID(Lexing.lexeme lexbuff) }
    | space*                { next_token lexbuf }
    | eof                   { EOF }
    | _                     { raise (Lexing_error (Lexing.lexeme lexbuff)) }