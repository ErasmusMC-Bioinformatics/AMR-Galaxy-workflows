#!/bin/bash

sed -i 's/"left": \([0-9]*\)\.[0-9]*/"left": \1/g' *.ga
sed -i 's/"top": \([0-9]*\)\.[0-9]*/"top": \1/g' *.ga

