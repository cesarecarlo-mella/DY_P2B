#!/bin/bash

PROC=$1
NCORES=5

#checks if number of loops is an integer
if [[ -n ${2//[0-9]/} ]]; then
    echo "Number of loops must be an integer (without L)"
    exit 1
fi

LOOPS=$2L
DIR=$PROC${3:-}/$LOOPS

if [ -d "$DIR" ]; then
    echo "The directory $DIR exists."
    read -p "Do you wish to overwrite it? (y/n): " answer

    if [ "$answer" = "n" ]; then
        echo "Terminating the script."
        exit 0
    elif [ "$answer" != "y" ]; then
        echo "Invalid input. Terminating the script."
        exit 1
    fi
fi

# keep the external folder if it exists
if [ -d "$DIR" ]
then
    if [ -d "$DIR/external" ]
    then
        mv $DIR/external/ $PROC/external
        rm -rf $DIR
        mkdir -p $DIR/external
        mv $PROC/external/ $DIR
    else
        rm -rf $DIR
    fi
fi

#make directories
mkdir -p $DIR
cd $DIR
if [ ! -d "external" ]
    then mkdir external
fi
mkdir drawings
mkdir -p tmp/ISP
mkdir -p tmp/prop_substitutions
mkdir -p tmp/words2moms
mkdir -p tmp/zeros

#copy template scripts
cp -r ../../Templates/* .

#substitute correct values into scripts
#external particle (Z/H/A)
EXT=${PROC:0:1}
perl -i -pe"s/&ext&/$EXT/g" common.py
perl -i -pe"s/&nloop&/$2/g" common.py
perl -i -pe"s/&proc&/$PROC/g" common.py
perl -i -pe"s/&ncores&/$NCORES/g" common.py
perl -i -pe"s/&type&/${3:-vector}/g" common.py