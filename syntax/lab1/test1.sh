#!/bin/bash

regex="s_^\s*\|\s*[;,\t]\s*_\t_g"
sed -e $regex t1.txt
sed -e $regex t2.txt
sed -e $regex kth.txt
