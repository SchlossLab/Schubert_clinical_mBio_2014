#!/bin/bash

mothur "#set.current(inputdir=data/mothur, outputdir=data/mothur, processors=8);
  get.groups(count=clinical.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table, fasta=clinical.unique.good.filter.unique.precluster.pick.pick.fasta, taxonomy=clinical.unique.good.filter.unique.precluster.pick.v35.wang.pick.taxonomy, groups=HD7UIAO01.MOCK-HD9SPZN01.MOCK-HJKE73L01.MOCK-HLFAWTL01.MOCK-HLFAWTL02.MOCK);
  seq.error(fasta=current, count=current, reference=data/references/HMP_MOCK.v35.fasta, aligned=F, processors=8)"


rm data/mothur/clinical.unique.good.filter.unique.precluster.pick.pick.pick.error.chimera
rm data/mothur/clinical.unique.good.filter.unique.precluster.pick.pick.pick.error.count
rm data/mothur/clinical.unique.good.filter.unique.precluster.pick.pick.pick.error.matrix
rm data/mothur/clinical.unique.good.filter.unique.precluster.pick.pick.pick.error.ref
rm data/mothur/clinical.unique.good.filter.unique.precluster.pick.pick.pick.error.seq*
