#!/bin/bash

components=("oneplace adder")


for cmp in $components
do 
  echo "Performing test on "$cmp""
  echo "=========================="
  echo "cycle
  " | actsim -Wlang_subst:off src/test.act "test_$cmp"
  echo "=========================="

done

