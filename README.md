# ocaml-drawing
ocaml code for functional drawing

How to compile and execute:

1. Building your .ml file with ocamlbuild :  
Type this command on your terminal, be sure to change the extension .ml to .byte:  
ocamlbuild -tag thread -use-ocamlfind -pkgs core,vg.svg path/to/your/file.byte


2. Execute it:
Once you've got your file.byte done, you then need to execute it from a terminal with:  
./stkbar_rect.byte

3. Visualisation :
Open your newly created .svg file with the browser of your choice.

