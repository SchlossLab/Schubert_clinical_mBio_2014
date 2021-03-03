#!/bin/bash

################################################################################
#
# get_denoised_data.sh
#
# Takes the run/time stamp from the sff file and runs the sff file through
# sffinfo, trim.flows, shhh.flows, trim.seqs, and unique.seqs
#
# dependencies:
#   * run/time stamp
#   * the sff file and oligos file need to be in data/raw
#
# output:
#   * fasta and names file corresponding to the denoised data
#
################################################################################

STUB=$1

RAW_DIR=data/raw
MOTHUR_DIR=data/mothur

mothur "#sffinfo(sff=$STUB.sff, inputdir=$RAW_DIR/, outputdir=$MOTHUR_DIR/);
        set.dir(input=$MOTHUR_DIR, output=$MOTHUR_DIR);
        trim.flows(flow=current, oligos=$RAW_DIR/$STUB.oligos, pdiffs=2, bdiffs=1, processors=8);"

ls $MOTHUR_DIR/$STUB.trim.*.flow | grep -v "NA.flow" > $MOTHUR_DIR/$STUB.flow.files

mothur "#shhh.flows(file=$STUB.flow.files, inputdir=$MOTHUR_DIR/, outputdir=$MOTHUR_DIR/);
        trim.seqs(fasta=$STUB.shhh.fasta, name=$STUB.shhh.names, oligos=$RAW_DIR/$STUB.oligos, pdiffs=2, bdiffs=1, maxhomop=8, minlength=200, flip=T, processors=8);
        unique.seqs(fasta=current, name=current)"

# garbage collection:
rm $MOTHUR_DIR/$STUB.flow
rm $MOTHUR_DIR/$STUB.fasta
rm $MOTHUR_DIR/$STUB.qual

rm $MOTHUR_DIR/$STUB.*.flow
rm $MOTHUR_DIR/$STUB.flow.groups
rm $MOTHUR_DIR/$STUB.flow.fasta
rm $MOTHUR_DIR/$STUB.flow.files

rm $MOTHUR_DIR/$STUB*.shhh.fasta
rm $MOTHUR_DIR/$STUB*.shhh.names
rm $MOTHUR_DIR/$STUB.*.shhh.counts
rm $MOTHUR_DIR/$STUB.*.shhh.groups
rm $MOTHUR_DIR/$STUB.*.shhh.qual

rm $MOTHUR_DIR/$STUB.shhh.trim.fasta
rm $MOTHUR_DIR/$STUB.shhh.scrap.fasta
rm $MOTHUR_DIR/$STUB.shhh.trim.names
rm $MOTHUR_DIR/$STUB.shhh.scrap.names
rm $MOTHUR_DIR/$STUB.shhh.scrap.qual
rm $MOTHUR_DIR/$STUB.shhh.trim.qual
