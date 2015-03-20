# ocaml-drawing
ocaml code for functional drawing

How to compile and execute:

1. Compilation with ocamlbuild:
    ```sh
    ocamlbuild -tag thread -use-ocamlfind -pkgs core,vg.svg path/to/your/file.byte
    ```

2. Execute it. Once you've got your file.byte done, you then need to execute it from a terminal with:  
    ```sh
    ./stkbar_rect.byte
    ```

3. Visualisation: open your newly created .svg file with the browser of your choice.

