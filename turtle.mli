(* Position and angle of the turtle *)
type position = {
  x: float;        (** position x *)
  y: float;        (** position y *)
  a: int;          (** angle of the direction *)
}

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

val cordinate : float -> int -> float -> (float -> float) -> int

(* Polar cordinate to cartesian for axe X and Y *)
val cordinateXY : position -> float -> int * int

(* draw line with Graphics.lineto *)
val draw_line : position -> float -> position

(* move the current point *)
val move_point : position -> float -> position

