open Syntax
exception Error of string

let op = function
  | Plus -> (+)
  | Moins -> (-)
  | Mult -> ( * )
  | Div -> (/)

let rec evaluate = function
  | Const n -> n
  | App (e1, o, e2) -> op o (evaluate e1) (evaluate e2)
  | Ident _ -> 0


let rec printDs ds = match ds with
  | [] -> ()
  | (Var e) :: t -> Printf.printf "Var %s\n" e; printDs t

let rec printIs is = match is with
  | BasPinceau -> Printf.printf "BasPinceau\n"
  | HautPinceau -> Printf.printf "HautPinceau\n"
  | Avance e -> Printf.printf "Avance %d\n" (evaluate e)
  | Tourne e -> Printf.printf "Tourne %d\n" (evaluate e)
  | BlocInstru bIs -> Printf.printf "Debut\n"; printBloc bIs; Printf.printf "Fin\n"
  | Equal (s, e) -> Printf.printf "%s = %d\n" s (evaluate e)

and printBloc bIs = match bIs with
  | [] -> ()
  | h :: t -> printIs h; printBloc t



let rec interpIs is = match is with
  | BasPinceau -> Turtle.isDOWN ()
  | HautPinceau -> Turtle.isUP ()
  | Avance e -> Turtle.avancer (evaluate e)
  | Tourne e -> Turtle.tourne (evaluate e)
  | BlocInstru bIs -> List.iter interpIs bIs 
  | Equal (s, e) -> Printf.printf "%s = %d\n" s (evaluate e)

(* print instruction *)
let print (ds, is) = printDs ds; printIs is

(* let program (ds, is) = print (ds, is);
  Turtle.start();
  ignore (Graphics.read_key ());
  Graphics.close_graph () *)

let program (ds, is) = interpIs is;
  Turtle.start();
  ignore (Graphics.read_key ());
  Graphics.close_graph ()



