#!/bin/bash

# From https://symbiyosys.readthedocs.io/en/latest/install.html

set -xe

sudo apt install -y build-essential clang bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz   \
                     xdot pkg-config python python3 libftdi-dev gperf \
                     libboost-program-options-dev autoconf libgmp-dev \
                     cmake

sudo apt install -y gtkwave

git clone https://github.com/YosysHQ/yosys.git yosys || true
pushd yosys
make -j$(nproc)
sudo make install
popd

git clone https://github.com/YosysHQ/SymbiYosys.git SymbiYosys || true
pushd SymbiYosys
sudo make install
popd

git clone https://github.com/SRI-CSL/yices2.git yices2 || true
pushd yices2
autoconf
./configure
make -j$(nproc)
sudo make install
popd

git clone https://github.com/Z3Prover/z3.git z3 || true
pushd z3
python scripts/mk_make.py
pushd build
make -j$(nproc)
sudo make install
popd
popd
