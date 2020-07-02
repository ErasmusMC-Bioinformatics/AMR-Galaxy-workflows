#!/bin/bash
oldversie=$1
newversie=$2

for i in *$oldversie.ga; do
	n="$(echo "$i" | sed "s/$oldversie/$newversie/")"
	cp "$i" "$n"
	sed -i "s/Report v$oldversie/Report v$newversie/" "$n"
done
