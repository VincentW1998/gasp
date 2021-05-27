open Graphics
exception Out_of_bounds;; 
let pen_position = ref false(* pen in Up position *) 
type color = Graphics.color
let color_Tbl = Hashtbl.create 5;;
List.iter (fun (kwd, tok) -> Hashtbl.add color_Tbl kwd tok)
[ ("noir", Graphics.black);
  ("rouge", Graphics.red);
  ("bleu", Graphics.blue);
  ("vert", Graphics.green);
  ("jaune", Graphics.yellow) ];;

let x = ref 0.
let y = ref 0.

let height = ref 800
let width = ref 800

(** constant pi **)
let pi = 4. *. atan(1.)

(** function change degree to rad**)
let degreeToRad = (fun x -> x *. pi /. 180.)

(* angle base *)
let angle = ref 90.

(** get the sign of x and add this sign to 0.5**)
let getSign = (fun x -> if x < 0. then (-0.5) else 0.5)

(** round the float **)
let roundFloat x =
  snd (modf (x +. getSign x))
  (* int_of_float (x +. getSign x) *)

(* Polar cordinate to cartesian for axe X *)
let cordinateX length =
  float_of_int(length)  *. cos (degreeToRad !angle)

(* Polar cordinate to cartesian for axe Y *)
let cordinateY length =
  float_of_int(length) *. sin (degreeToRad !angle)

let tourne a = angle := !angle +. (float_of_int a)

let isUp () = pen_position := false

let isDown () = pen_position := true

let isOutOfBounds () = 
  if !x < 0. || !y < 0. || !x > float_of_int !width || !y > float_of_int !height  then 
    raise Out_of_bounds

let draw a = 
  x := roundFloat(!x +. cordinateX a);
  y := roundFloat(!y +. cordinateY a);
  if !pen_position then (lineto (int_of_float !x) (int_of_float !y); isOutOfBounds())
  else moveto (int_of_float !x) (int_of_float !y)

let setColor c = Graphics.set_color c

let setWidth e = Graphics.set_line_width e

let start () = open_graph (" " ^ string_of_int !width ^ "x" ^ string_of_int !height); moveto (int_of_float !x) (int_of_float !y)
