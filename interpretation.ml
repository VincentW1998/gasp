open Syntax
exception Error of string
exception Undeclared_variable

let i = ref 0
let var_Tbl = Hashtbl.create 100;;

let op = function
  | Plus -> (+)
  | Moins -> (-)
  | Mult -> ( * )
  | Div -> (/)

let rec evaluate = function
  | Const n -> n
  | App (e1, o, e2) -> op o (evaluate e1) (evaluate e2)
  | Ident s -> Hashtbl.find var_Tbl s

let modifyVar s e = 
  match Hashtbl.find_opt var_Tbl s with
  | None -> raise Undeclared_variable
  | _ -> Hashtbl.replace var_Tbl s (evaluate e)



(* let rec printDs ds = match ds with
  | [] -> ()
  | (Var e) :: t -> Printf.printf "Var %s\n" e; printDs t

let rec printIs is = match is with
  | BasPinceau -> Printf.printf "%d BasPinceau\n" !i; i := !i+1;
  | HautPinceau -> Printf.printf "%d HautPinceau\n" !i; i := !i+1;
  | Avance e -> Printf.printf "%d Avance %d\n" !i (evaluate e); i := !i+1;
  | Tourne e -> Printf.printf "%d Tourne %d\n" !i (evaluate e); i := !i+1;
  | BlocInstru bIs -> Printf.printf "Debut\n"; printBloc bIs; Printf.printf "Fin\n"
  | Equal (s, e) -> modifyVar s e ; Printf.printf "%d %s = %d\n" !i s (evaluate e); i := !i+1;
  | IfAlorsSinon (e, i1, i2) -> Printf.printf "If  Alors Sinon\n"
  | TantFaire (e, i1) -> Printf.printf "Tant que Faire\n"

and printBloc bIs = match bIs with
  | [] -> ()
  | h :: t -> printIs h; printBloc t

(* print instruction *)
let print (ds, is) = printDs ds; printIs is *)

let rec interpDs ds = match ds with
  | [] -> ()
  | (Var e) :: t -> if (Hashtbl.find_opt var_Tbl e) == None then Hashtbl.add var_Tbl e 0; interpDs t


let rec interpIs is = match is with
  | BasPinceau -> Turtle.isDown ()
  | HautPinceau -> Turtle.isUp ()
  | Avance e -> Turtle.draw (evaluate e)
  | Tourne e -> Turtle.tourne (evaluate e)
  | IfAlorsSinon (e, i1, i2) -> interpIs (if (evaluate e) <> 0 then i1 else i2)
  | TantFaire (e, i1) -> while (evaluate e) <> 0 do interpIs i1 done
  | BlocInstru bIs -> List.iter interpIs bIs 
  | Equal (s, e) -> modifyVar s e
  | ChangeColor c -> Turtle.setColor c
  | ChangeWidth e -> Turtle.setWidth (evaluate e)
   


let program (ds, is) = 
  Turtle.start();
  interpDs ds;
  (* printIs is; *)
  interpIs is;
  ignore (Graphics.read_key ());
  (* printDs ds; *)
  Graphics.close_graph ()