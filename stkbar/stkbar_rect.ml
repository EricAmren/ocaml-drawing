(*#require "core";;
#require "vg";;
#require "gg";;
*)
open Core.Std;;
open Vg;;
open Gg;;


let stkbar_color = I.const Color.blue;;
let stkbar_path =
    let size = Size2.v 0.3 0.8 in
    let box = Box2.v_mid P2.o size in
        P.empty >>
        P.rect box;;

let stkbar_image = I.cut stkbar_path stkbar_color;;

let portion_color = I.const Color.red;;
let stkbar_portion_path =
  let size = Size2.v 0.3 0.24 in
  let p = P2.v 0. (-. 0.28) in
    let box = Box2.v_mid p size in
        P.empty >>
        P.rect box;;

let stkbar_portion_image = I.cut stkbar_portion_path portion_color;;

let stkbar_outline =
  let area = `O { P.o with P.width = 0.01 } in
  let black = I.const Color.black in
    I.cut ~area stkbar_path black;;

let portion_stkbar_outline =
  let area = `O { P.o with P.width = 0.01 } in
  let black = I.const Color.black in
    I.cut ~area stkbar_portion_path black;;

let stkbar = I.blend stkbar_portion_image stkbar_image;;
let outline = I.blend stkbar_outline portion_stkbar_outline;;
let stkbar_rect = I.blend outline stkbar;; 

(*Rendu*)
let render img fn =
  let aspect = 1. in
  let size = Size2.v (aspect *. 100.) 100. in
  let view = Box2.v_mid P2.o (Size2.v aspect 1.) in
  let xmp = Vgr.xmp () in
  let warn w = Vgr.pp_warning Format.err_formatter w in
  Out_channel.with_file fn ~f:(fun oc ->
      let r = Vgr.create ~warn (Vgr_svg.target ~xmp ()) (`Channel oc) in
      ignore (Vgr.render r (`Image (size, view, img)));
      ignore (Vgr.render r `End)
    );;


let () = render stkbar_rect "stkbar_rect.svg";;







