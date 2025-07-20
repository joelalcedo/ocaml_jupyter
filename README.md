# Running OCaml from a Jupyter Notebook

The [OCaml‑Jupyter kernel](https://github.com/akabe/ocaml-jupyter) does **not** yet support OCaml 5.0+. To experiment in notebooks you’ll need to create a project on an OCaml 4.14 (or earlier) switch and register the kernel manually.

## 1 · Create a project

<code>```dune init project [some project name] ```</code>.

## 2 · Verify jupyter installation

<code>```jupyter --version```</code>.

## 3 · Install the kernel spec

<code>```jupyter kernelspec install --user --name ocaml-jupyter "$(opam var share)/jupyter"```</code>.

Verify the kernel is installed:

<code>```jupyter kernelspec list```</code>.

Assuming the kernel is correcly installed then you should be able to select from the list of kernels in VS code.

<img width="1864" height="330" alt="image" src="https://github.com/user-attachments/assets/682eb10d-b77a-48ad-bab2-ac6dfeb04c84" />

This will not work if you are running OCaml 5.0+. If you are, in your  project directory, you will need to create a switch: 

# a) create a switch in the project directory
<code>```opam switch create . 4.14.2```</code>.
<code>```eval $(opam env)```</code>.

# b) install the kernel into that switch
<code>```opam install jupyter dune utop```</code>.

# c) generate and register the kernelspec
<code>```ocaml-jupyter-opam-genspec```</code>.
<code>```jupyter kernelspec install --user --name ocaml-jupyter "$(opam var share)/jupyter"```</code>.

## 4 · Write inline code

Then you can write & test code inline with ease, e.g.:

<img width="2176" height="634" alt="image" src="https://github.com/user-attachments/assets/8cc2dd5c-27e7-49ce-b0dc-906746a895dd" />
