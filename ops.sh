#!/bin/bash 

cd $(dirname $0)

OPS_DIR=$PWD
OPS_PY=$OPS_DIR/ops.py


mk_osm_dirs () {
    # Args: dirpath=$PWD, fname=seed
    # Returns: Makes $PWD/seed/ and addes relevant dirs for sim
    dpath=$1; fname=$2
    osm_dpath=$dpath/$fname    
    if [ -d $osm_dpath ]; then 
        echo "Dir $osm_dpath already exists. Remove and try again."
        python -c "assert False"
    else
        mkdir $osm_dpath
        cp $OPS_DIR/ref/* $osm_dpath
    fi
}


# TODO How to pass args to python script?
argparse_script=$(cat << EOF
from argparse import ArgumentParser
import os
parser = ArgumentParser("ops")
parser.add_argument("-seed", type=str, default="$PWD/seed.osm")
parser.add_argument("-mkdir", type=str, default="$PWD/seed")
args = parser.parse_args()
if arg.seed:
    fpath=$(python $OPS_PY -seed)
    dpath=$(dirname $fpath)
    fname=$(basename $fpath).replace(".osm")
    mkdir_osm=$(mkdir_osm dpath fname) 
    print(fpath)
if arg.mkdir:
    assert '.osm' not in arg.mkdir, \
        f"Must not include .osm in arg, got {arg.mkdir}."
    osm_dpath = arg.mkdir
    print($mkdir_osm osm_dpath)
EOF
)

# Argparse
python -c "$argparse_script" "$@"

