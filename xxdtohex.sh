#!/bin/bash

if [ -z $1 ]; then
    echo -e "\x1B[31mError: binary file required\x1B[0m"
    exit -1
fi

if [ ! -f $1 ]; then
    echo -e "\x1B[31mInput file does not exist\x1B[0m"
    exit -1
fi

output_file="output.txt"  # <<< Here is output file name (you can change file name)

echo -ne "\x1B[01;93m"

xxd -p $1 | sed ':a;N;$!ba;s/\n/ /g' | sed 's/ //g' | sed 's/\(.\{2\}\)/\1,(byte)0x/g' | sed 's/^/public final static byte[] cert = new byte[]{0x/' | sed 's/\(,(byte)0x\)$/};/' > $output_file

echo -ne "\x1B[0m"
echo -e "\x1B[32mOutput saved to $output_file\x1B[0m"
