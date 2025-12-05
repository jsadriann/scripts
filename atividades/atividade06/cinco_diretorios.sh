#!/bin/bash

mkdir cinco
cd cinco

for int in {1..5}
do
	mkdir dir${int}
	cd dir${int}
	for sub in {1..4}
	do
		touch arq${sub}.txt
		for a in $(seq 1 ${sub})
		do
			echo ${sub} >> arq${sub}.txt
		done
	done
	cd ..
done

