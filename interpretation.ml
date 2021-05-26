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

let modifyVar s e = 
  match Hashtbl.find_opt !Turtle.var_Tbl s with
  | None -> Printf.printf "None\n"
  | _ -> Hashtbl.replace !Turtle.var_Tbl s (evaluate e); Printf.printf "%s is %d\n" s (Hashtbl.find !Turtle.var_Tbl s) 



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

(* print instruction *)
let print (ds, is) = printDs ds; printIs is

let rec interpDs ds = match ds with
  | [] -> ()
  | (Var e) :: t -> if (Hashtbl.find_opt !Turtle.var_Tbl e) == None then Hashtbl.add !Turtle.var_Tbl e 0; interpDs t

    
let rec interpIs is = match is with
  | BasPinceau -> Turtle.isDown ()
  | HautPinceau -> Turtle.isUp ()
  | Avance e -> Turtle.avancer (evaluate e)
  | Tourne e -> Turtle.tourne (evaluate e)
  | BlocInstru bIs -> List.iter interpIs bIs 
  | Equal (s, e) -> modifyVar s e



(* let program (ds, is) = 
  Turtle.start();
  print (ds, is);
  ignore (Graphics.read_key ());
  Graphics.close_graph () *)

let program (ds, is) = 
  Turtle.start();
  interpDs ds;
  interpIs is;
  ignore (Graphics.read_key ());
  (* printDs ds; *)
  Graphics.close_graph ()



