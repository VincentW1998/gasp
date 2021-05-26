
(** get the sign of x and add this sign to 0.5**)
val getSign : float -> float

(** function change degree to rad**)
val degreeToRad : int -> float

(** round the float **)
val roundFloat : float -> int

(* Polar cordinate to cartesian for axe X *)
val cordinateX : position -> float -> int

(* Polar cordinate to cartesian for axe Y *)
val cordinateY : position -> float -> int

val isUP : unit -> unit = <fun>

val isDown : unit -> unit = <fun>

val start : unit -> unit

