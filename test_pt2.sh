#!/bin/bash

components=("oneplace adder")


for cmp in $components
do 
  echo "Converting $cmp to prs"
  chp2prs -b -o abc -e build/expr.act src/$cmp.act $cmp build/"$cmp"_prs.act
  echo "
=========================="
done


for cmp in $components
do
  echo "Performing test on $cmp"
  echo "=========================="
  echo "cycle
  " | actsim -Wlang_subst:off src/test_prs.act "test_$cmp"
  echo "=========================="
done
