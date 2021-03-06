val color_Tbl : (string, Graphics.color) Hashtbl.t 

type color

val pen_position : bool ref

(** get the sign of x and add this sign to 0.5**)
val getSign : float -> float

(** function change degree to rad**)
val degreeToRad : float -> float

(** round the float **)
val roundFloat : float -> float
(* val roundFloat : float -> int *)

(* Polar cordinate to cartesian for axe X *)
val cordinateX : int -> float 

(* Polar cordinate to cartesian for axe Y *)
val cordinateY : int -> float  

val isUp : unit -> unit 

val isDown : unit -> unit

val tourne : int -> unit 

val draw : int -> unit

val isOutOfBounds : unit -> unit

val setColor : Graphics.color -> unit

val setWidth : int -> unit

val start : unit -> unit

