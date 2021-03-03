MOTHUR=data/mothur
BASIC_STEM=$MOTHUR/clinical.unique.good.filter.unique.precluster

mothur "#set.current(inputdir=$MOTHUR, outputdir=$MOTHUR, processors=8);
  remove.groups(count=clinical.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table, fasta=clinical.unique.good.filter.unique.precluster.pick.pick.fasta, taxonomy=clinical.unique.good.filter.unique.precluster.pick.v35.wang.pick.taxonomy, groups=HD7UIAO01.MOCK-HD9SPZN01.MOCK-HJKE73L01.MOCK-HLFAWTL01.MOCK-HLFAWTL02.MOCK-HD7UIAO01.GD-HD9SPZN01.GD-HJKE73L01.GD-HLFAWTL01.GD-HLFAWTL02.GD);
  dist.seqs(fasta=current, cutoff=0.03);
  cluster(column=current, count=current, cutoff=0.03);
  make.shared(list=current, count=current, label=0.03);
  classify.otu(list=current, count=current, taxonomy=current, label=0.03)"

rm $BASIC_STEM.denovo.uchime.pick.pick.pick.count_table
rm $BASIC_STEM.pick.pick.pick.fasta
rm $BASIC_STEM.pick.v35.wang.pick.pick.taxonomy
rm $BASIC_STEM.pick.pick.pick.opti_mcc.0.03.cons.tax.summary
rm $BASIC_STEM.pick.pick.pick.opti_mcc.steps
rm $BASIC_STEM.pick.pick.pick.opti_mcc.sensspec
rm $BASIC_STEM.pick.pick.pick.opti_mcc.list
rm $BASIC_STEM.pick.pick.pick.dist
