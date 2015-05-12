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
#   * fasta, group, and names file corresponding to the denoised data
#
################################################################################



STUB=$1

RAW_DIR=data/raw/
MOTHUR_DIR=data/mothur/

mothur "#sffinfo(sff=$SFF.sff, inputdir=$RAW_DIR, outputdir=$MOTHUR_DIR);
        set.dir(input=data/mothur, output=data/mothur);
        trim.flows(flow=current, oligos=data/raw/$STUB.oligos, pdiffs=2, bdiffs=1, processors=8);
        shhh.flows(file=current);
        trim.seqs(fasta=current, name=current, oligos=current, pdiffs=2, bdiffs=1, maxhomop=8, minlength=200, flip=T);
        unique.seqs(fasta=current, name=current)"

#TEMP=$(echo $F_FASTQ | sed -e s/raw/process/)
#CONTIG_FASTA=$(echo $TEMP | sed -e s/fastq/trim.contigs.fasta/)
#CONTIG_REPORT=$(echo $TEMP | sed -e s/fastq/contigs.report/)


#   delete:
#   data/mothur/HD7UIAO01.trim.flow
#   data/mothur/HD7UIAO01.scrap.flow
#   data/mothur/HD7UIAO01.DA*.flow
