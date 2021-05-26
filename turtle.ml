open Graphics
let pen_position = ref true(* pen in Up position *) 
exception Out_of_bounds;; 

let x = ref 0.
let y = ref 0.

let height = ref 800
let width = ref 800

(** constant pi **)
let pi = 4. *. atan(1.)

(** function change degree to rad**)
let degreeToRad = (fun x -> x *. (pi /. 180.))

(* angle base *)
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

let isUp () = pen_position := false

let isDown () = pen_position := true

let isOutOfBounds () = 
  if !x < 0. || !y < 0. || !x > float_of_int !width || !y > float_of_int !height then 
    raise Out_of_bounds

let avancer a = 
  x := !x +. cordinateX a;
  y := !x +. cordinateY a;
  if !pen_position then (lineto (roundFloat !x) (roundFloat !y); isOutOfBounds())
  else moveto (roundFloat !x) (roundFloat !y)


let start () = open_graph (" " ^ string_of_int !width ^ "x" ^ string_of_int !height); moveto (int_of_float !x) (int_of_float !y)


