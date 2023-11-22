#!/bin/bash
set -e

opam init -y --auto-setup --root /container/.opam
opam update
opam switch create 4.06.1+flambda
eval `opam config env`
opam install -y  ppx_jane core re2 yojson vg cairo2 camlimages menhir ocaml-protoc zmq utop jbuilder
echo "
#use "topfind";;
#thread;;
#require "core.top";;
#require "core.syntax";;
open Core;;
" >> /container/.ocamlinit
echo 'eval `opam config env`' >> /container/.bashrc  

bash