#!/bin/bash
awk '{ OFS = "\t"; if($1=="chr12"&&$4>=25180735&&$5<=25597454&&$3=="transcript") print $0}' susScr11.ncbiRefSeq.gtf | gtf2bed | awk '{ OFS = "\t"; $5=0 ;print $0}' | cut -f1,2,3,4,5,6 > temp.bed
Rscript bedfile.R temp.bed B4GALNT2.bed