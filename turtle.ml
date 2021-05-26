open Graphics

let pen_position = ref true
let isUp () = pen_position := false
let isDown () = pen_position := true
let x = ref 0.
let y = ref 0.
let var_Tbl = ref (Hashtbl.create 100);;

(** constant pi **)
let pi = 4. *. atan(1.)

(** function change degree to rad**)
let degreeToRad = (fun x -> x *. (pi /. 180.))

let angle = ref (degreeToRad 90.)

(** get the sign of x and add this sign to 0.5**)
let getSign = (fun x -> if x < 0. then (-0.5) else 0.5)

(** round the float **)
let roundFloat x =
  int_of_float (x +. getSign x)

(* Polar cordinate to cartesian for axe X *)
let cordinateX length =
  float_of_int(length)  *. cos (!angle)

(* Polar cordinate to cartesian for axe Y *)
let cordinateY length =
  float_of_int(length) *. sin (!angle)

let tourne a = angle := !angle +. degreeToRad (float_of_int a)

let avancer a = 
  x := !x +. cordinateX a;
  y := !x +. cordinateY a;
  if !pen_position then lineto (roundFloat !x) (roundFloat !y)
  else moveto (roundFloat !x) (roundFloat !y)

open Graphics
let start () = open_graph " 800x800"


