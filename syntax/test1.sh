#!/bin/bash

sed -e "s_^\s*\|\s*[;,\t]\s*_\t_g" t1.txt
sed -e "s_^\s*\|\s*[;,\t]\s*_\t_g" t2.txt
sed -e "s_^\s*\|\s*[;,\t]\s*_\t_g" kth.txt
