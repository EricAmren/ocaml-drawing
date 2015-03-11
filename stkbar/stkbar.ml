(*#require "core";;
#require "vg";;
#require "gg";;
*)
open Core.Std;;
open Vg;;
open Gg;;

(*--partie 1*)
let stkbar_color = I.const Color.blue;;
let stkbar_path = 
  P.empty >>
  P.sub (V2.v (-. 0.15) (-. 0.4)) >>
    P.line ~rel:true (V2.v 0.3 0.) >>
    P.line ~rel:true (V2.v 0. 0.8) >>
    P.line ~rel:true (V2.v (-. 0.3) 0.) >>
    P.close;;

let stkbar_image = I.cut stkbar_path stkbar_color;;

(*--partie 2*)
let portion_color = I.const Color.red;;
let stkbar_portion_path =
  P.empty >>
  P.sub (V2.v (-. 0.15) (-0.4)) >>
    P.line ~rel:true (V2.v 0.3 0.) >>
    P.line ~rel:true (V2.v 0. 0.24) >>
    P.line ~rel:true (V2.v (-. 0.3) 0.) >>
    P.close;;

let stkbar_portion_image = I.cut stkbar_portion_path portion_color;;

(*--partie 3 : contours*)

let stkbar_outline =
  let area = `O { P.o with P.width = 0.04 } in
  let black = I.const Color.black in
    I.cut ~area stkbar_path black;;

let portion_stkbar_outline =
  let area = `O { P.o with P.width = 0.04 } in
  let black = I.const Color.black in
    I.cut ~area stkbar_portion_path black;;

(*--partie 4 : blend*)

let stkbar = I.blend stkbar_portion_image stkbar_image;;
let outline = I.blend stkbar_outline portion_stkbar_outline;;
let stkbar_outlined = I.blend outline stkbar;; 

(*Rendu*)
let render img fn =
  let aspect = 2. in
  let size = Size2.v (aspect *. 100.) 100. in
  let view = Box2.v P2.o (Size2.v aspect 1.) in
  let xmp = Vgr.xmp () in
  let warn w = Vgr.pp_warning Format.err_formatter w in
  Out_channel.with_file fn ~f:(fun oc ->
      let r = Vgr.create ~warn (Vgr_svg.target ~xmp ()) (`Channel oc) in
      ignore (Vgr.render r (`Image (size, view, I.move (V2.v 0.5 0.5) img)));
      ignore (Vgr.render r `End)
    );;


let () = render stkbar_outlined "stkbar_outlined.svg";;

