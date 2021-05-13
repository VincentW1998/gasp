open Graphics

let x = ref 0.
let y = ref 0.

let angle = ref 

let pinceau_position = ref true 

let pinceau = function 
  | "Haut" -> pinceau_position := true
  | "Bas" -> pinceau_position := false
  | _ -> ()

(** constant pi **)
let pi = 4. *. atan(1.)

(** function change degree to rad**)
let degreeToRad = (fun x -> (float_of_int x) *. (pi /. 180.))

(** get the sign of x and add this sign to 0.5**)
let getSign = (fun x -> if x < 0. then (-0.5) else 0.5)

(** round the float **)
let roundFloat x =
  int_of_float (x +. getSign x)

let () = open_graph " 800x800"


