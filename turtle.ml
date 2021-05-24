open Graphics

(* Mon ancien code pour mon projet de PF5  *)

type position = {
  x: float;      (** position x *)
  y: float;      (** position y *)
  a: int;        (** angle of the direction *)
}

(* let pinceau = function 
  | "Haut" -> pinceau_position := true
  | "Bas" -> pinceau_position := false
  | _ -> () *)

(** constant pi **)
let pi = 4. *. atan(1.)

(** function change degree to rad**)
let degreeToRad = (fun x -> (float_of_int x) *. (pi /. 180.))

(** get the sign of x and add this sign to 0.5**)
let getSign = (fun x -> if x < 0. then (-0.5) else 0.5)

(** round the float **)
let roundFloat x =
  int_of_float (x +. getSign x)

(* Polar cordinate to cartesian for axe X *)
let cordinateX p length =
  int_of_float (p.x) + roundFloat(length  *. cos (degreeToRad p.a))

(* Polar cordinate to cartesian for axe Y *)
let cordinateY p length =
 int_of_float (p.y) + roundFloat(length *. sin (degreeToRad p.a))

let cordinate p a length f =
 int_of_float p + roundFloat(length *. f(degreeToRad a))

(* Polar cordinate to cartesian for axe X and Y *)
let cordinateXY p length =
 let x1 = cordinateX p length and
   y1 = cordinateY p length in
   (x1, y1)

(* draw line with Graphics.lineto *)
let draw_line pos taille =
let taille2 = if taille < 1. then 1. else taille in
 let (x1, y1)  = cordinateXY pos taille2 in lineto x1 y1;
 {x = (float_of_int x1); y = (float_of_int y1); a = pos.a}

(* move the current point *)
let move_point pos a =
  let (x1, y1) = cordinateXY pos a in moveto x1 y1;
  {x = (float_of_int x1); y = (float_of_int y1); a = pos.a}

let () = open_graph " 800x800"


