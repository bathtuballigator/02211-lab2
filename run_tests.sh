#!/bin/bash

echo "Performing test on Adder"
echo "============================="
echo "cycle
" | actsim -Wlang_subst:off src/test.act "test_adder"
echo "============================="
echo "Performing test on oneplace buffer"
echo "============================="
echo "cycle
" | actsim -Wlang_subst:off src/test.act "test_oneplace"

