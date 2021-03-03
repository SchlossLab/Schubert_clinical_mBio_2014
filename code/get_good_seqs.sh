MOTHUR=data/mothur

mothur "#set.dir(input=$MOTHUR, output=$MOTHUR);
  set.current(processors=8);
  unique.seqs(fasta=clinical.fasta, name=clinical.names);
  count.seqs(name=current, group=clinical.groups);
  align.seqs(fasta=current, reference=data/references/silva.v35.align);
  screen.seqs(fasta=current, count=current, start=14886, end=21271);
  filter.seqs(fasta=current, vertical=T, trump=.);
  unique.seqs(fasta=current, count=current);
  pre.cluster(fasta=current, count=current, diffs=2);
  chimera.uchime(fasta=current, count=current, dereplicate=T);
  remove.seqs(fasta=current, accnos=current);
  classify.seqs(fasta=current, count=current, reference=data/references/trainset18_062020.v35.fasta, taxonomy=data/references/trainset18_062020.v35.tax, cutoff=80);
  remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);"

rm $MOTHUR/clinical*.unique.fasta
rm $MOTHUR/clinical*.unique.names
rm $MOTHUR/clinical*.unique.count_table
rm $MOTHUR/clinical*.align*
rm $MOTHUR/clinical*.accnos
rm $MOTHUR/clinical.unique.good.count_table
rm $MOTHUR/clinical.filter
rm $MOTHUR/clinical.unique.good.filter.fasta
rm $MOTHUR/clinical.unique.good.filter.count_table
rm $MOTHUR/clinical*.map
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.count_table
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.fasta
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.*DA*.fasta
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.*DA*.count_table
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.*MOCK*.fasta
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.*MOCK*.count_table
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.*GD*.fasta
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.*GD*.count_table
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.denovo.uchime.chimeras
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.denovo.uchime.pick.count_table
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.pick.fasta
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.pick.v35.wang.tax.summary
rm $MOTHUR/clinical.unique.good.filter.unique.precluster.pick.v35.wang.taxonomy
