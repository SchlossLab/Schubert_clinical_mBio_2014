################################################################################
#
#	Part 1: Get the reference files
#
#	Here we give instructions on how to get the necessary reference files that
#	are used throughout the rest of the analysis. These are used to calculate
#	error rates, generate alignments, and classify sequences. We will pull down
#	the mock community reference (HMP_MOCK.fasta), the silva reference alignment
#	(silva.bacteria.align), and the RDP training set data (trainset9_032012).
#	Finally, we use the HMP_MOCK.align to get the alignment coordinates for the
#	v35 data. These data will be stored in the data/references/ folder.
#
#	The targets in this part are all used as dependencies in other rules
#
################################################################################

#Location of reference files
REFS = data/references/

#get the silva reference alignment
$(REFS)silva.bacteria.align :
	wget -N -P $(REFS) https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.nr_v138_1.tgz; \
	tar xvzf $(REFS)silva.nr_v138_1.tgz -C $(REFS);
	mothur "#get.lineage(fasta=$(REFS)silva.nr_v138_1.align, taxonomy=$(REFS)silva.nr_v138_1.tax, taxon=Bacteria)";
	mv $(REFS)silva.nr_v138_1.pick.align $(REFS)silva.bacteria.align; \
	rm $(REFS)silva.nr_v138_1.*
	git checkout -- $(REFS)README.md

#get the v35 region of the alignment
$(REFS)silva.v35.align : $(REFS)silva.bacteria.align
	mothur "#pcr.seqs(fasta=$(REFS)silva.bacteria.align, start=6388, end=27659, keepdots=F, processors=8);\
			unique.seqs(fasta=current);"; \
	mv $(REFS)silva.bacteria.pcr.unique.align $(REFS)silva.v35.align; \
	rm $(REFS)silva.bacteria.pcr.*

#get the rdp training set data
$(REFS)trainset18_062020.pds.tax $(REFS)trainset18_062020.pds.fasta :
	wget -N -P $(REFS) https://mothur.s3.us-east-2.amazonaws.com/wiki/trainset18_062020.pds.tgz; \
	tar xvzf $(REFS)trainset18_062020.pds.tgz -C $(REFS);\
	mv $(REFS)trainset18_062020.pds/trainset18_062020.* $(REFS);\
	rm -rf $(REFS)trainset18_062020.pds

#get the v35 region of the RDP training set
$(REFS)trainset18_062020.v35.tax $(REFS)trainset18_062020.v35.fasta : \
						$(REFS)trainset18_062020.pds.tax \
						$(REFS)trainset18_062020.pds.fasta \
						$(REFS)silva.v35.align
	mothur "#align.seqs(fasta=$(REFS)trainset18_062020.pds.fasta, reference=$(REFS)silva.v35.align, processors=8);\
		screen.seqs(fasta=current, taxonomy=$(REFS)trainset18_062020.pds.tax, start=1, end=21271);\
		degap.seqs(fasta=current)"; \
	mv $(REFS)trainset18_062020.pds.good.ng.fasta $(REFS)trainset18_062020.v35.fasta; \
	mv $(REFS)trainset18_062020.pds.good.tax $(REFS)trainset18_062020.v35.tax;\
	rm $(REFS)trainset18_062020.pds.align*;\
	rm $(REFS)trainset18_062020.pds.bad.accnos;\
	rm $(REFS)trainset18_062020.pds.flip.accnos;

$(REFS)HMP_MOCK.fasta :
	wget --no-check-certificate -N -P $(REFS) https://raw.githubusercontent.com/SchlossLab/Kozich_MiSeqSOP_AEM_2013/master/data/references/HMP_MOCK.fasta

#align the mock community reference sequeces
$(REFS)HMP_MOCK.v35.fasta : $(REFS)HMP_MOCK.fasta $(REFS)silva.v35.align
	mothur "#align.seqs(fasta=$(REFS)HMP_MOCK.fasta, reference=$(REFS)silva.v35.align);\
			degap.seqs()";\
	mv $(REFS)HMP_MOCK.ng.fasta $(REFS)HMP_MOCK.v35.fasta;\
	rm -f $(REFS)HMP_MOCK.align;\
	rm -f $(REFS)HMP_MOCK.align.report;\
	rm -f $(REFS)HMP_MOCK.flip.accnos

data/mothur/LookUp_Titanium.pat :
	wget -N https://mothur.s3.us-east-2.amazonaws.com/wiki/lookup_titanium.zip
	unzip lookup_titanium.zip
	mv LookUp_Titanium.pat $@
	rm lookup_titanium.zip

references : $(REFS)HMP_MOCK.v35.fasta $(REFS)trainset18_062020.v35.tax $(REFS)trainset18_062020.v35.fasta $(REFS)silva.v35.align data/mothur/LookUp_Titanium.pat

################################################################################
#
#	Part 2: Get raw data
#
################################################################################

RAW=data/raw
MOTHUR_LINK=https://mothur.s3.us-east-2.amazonaws.com/data/CDI_MicrobiomeModeling
#need to pull the data off of the mothur server

#https://mothur.s3.us-east-2.amazonaws.com/data/CDI_MicrobiomeModeling/HD7UIAO01.oligos

$(RAW)/HD9SPZN01.sff $(RAW)/HD9SPZN01.oligos :
	wget -N -P $(RAW) $(MOTHUR_LINK)/HD9SPZN01.sff.bz2
	bunzip2 $(RAW)/HD9SPZN01.sff.bz2
	wget -N -P data/raw/ $(MOTHUR_LINK)/HD9SPZN01.oligos

$(RAW)/HD7UIAO01.sff $(RAW)/HD7UIAO01.oligos :
	wget -N -P $(RAW) $(MOTHUR_LINK)/HD7UIAO01.sff.bz2
	bunzip2 $(RAW)/HD7UIAO01.sff.bz2
	wget -N -P $(RAW) $(MOTHUR_LINK)/HD7UIAO01.oligos

$(RAW)/HJKE73L01.sff $(RAW)/HJKE73L01.oligos :
	wget -N -P $(RAW) $(MOTHUR_LINK)/HJKE73L01.sff.bz2
	bunzip2 $(RAW)/HJKE73L01.sff.bz2
	wget -N -P $(RAW) $(MOTHUR_LINK)/HJKE73L01.oligos

$(RAW)/HLFAWTL01.sff $(RAW)/HLFAWTL01.oligos :
	wget -N -P $(RAW) $(MOTHUR_LINK)/HLFAWTL01.sff.bz2
	bunzip2 $(RAW)/HLFAWTL01.sff.bz2
	wget -N -P $(RAW) $(MOTHUR_LINK)/HLFAWTL01.oligos

$(RAW)/HLFAWTL02.sff $(RAW)/HLFAWTL02.oligos :
	wget -N -P $(RAW) $(MOTHUR_LINK)/HLFAWTL02.sff.bz2
	bunzip2 $(RAW)/HLFAWTL02.sff.bz2
	wget -N -P $(RAW) $(MOTHUR_LINK)/HLFAWTL02.oligos

$(RAW)/MIMARKS_cdclinical.xlsx :
	wget -N -P $(RAW) $(MOTHUR_LINK)/MIMARKS_cdclinical.xlsx

get_raw_data : $(RAW)/HD9SPZN01.sff $(RAW)/HD9SPZN01.oligos\
				$(RAW)/HD7UIAO01.sff $(RAW)/HD7UIAO01.oligos\
				$(RAW)/HJKE73L01.sff $(RAW)/HJKE73L01.oligos\
				$(RAW)/HLFAWTL01.sff $(RAW)/HLFAWTL01.oligos\
				$(RAW)/HLFAWTL02.sff $(RAW)/HLFAWTL02.oligos\
				$(RAW)/MIMARKS_cdclinical.xlsx


################################################################################
#
#	Part 3: Run data through mothur
#
################################################################################

MOTHUR = data/mothur

# here we denoise the data by running each sff file through sffinfo, trim.flows,
# shhh.flows, trim.seqs, and unique.seqs. We produce the denoised fasta, names,
# and groups file. These will take a while to run in series, probably best to
# run them separately in parallel.

$(MOTHUR)/HD9SPZN01.shhh.trim.unique.fasta $(MOTHUR)/HD9SPZN01.shhh.trim.unique.names $(MOTHUR)/HD9SPZN01.shhh.groups : code/get_denoised_data.sh $(RAW)/HD9SPZN01.sff $(RAW)/HD9SPZN01.oligos
	code/get_denoised_data.sh HD9SPZN01

$(MOTHUR)/HD7UIAO01.shhh.trim.unique.fasta $(MOTHUR)/HD7UIAO01.shhh.trim.unique.names $(MOTHUR)/HD7UIAO01.shhh.groups : code/get_denoised_data.sh $(RAW)/HD7UIAO01.sff $(RAW)/HD7UIAO01.oligos
	code/get_denoised_data.sh HD7UIAO01

$(MOTHUR)/HJKE73L01.shhh.trim.unique.fasta $(MOTHUR)/HJKE73L01.shhh.trim.unique.names $(MOTHUR)/HJKE73L01.shhh.groups : code/get_denoised_data.sh $(RAW)/HJKE73L01.sff $(RAW)/HJKE73L01.oligos
	code/get_denoised_data.sh HJKE73L01

$(MOTHUR)/HLFAWTL01.shhh.trim.unique.fasta $(MOTHUR)/HLFAWTL01.shhh.trim.unique.names $(MOTHUR)/HLFAWTL01.shhh.groups : code/get_denoised_data.sh $(RAW)/HLFAWTL01.sff $(RAW)/HLFAWTL01.oligos
	code/get_denoised_data.sh HLFAWTL01

$(MOTHUR)/HLFAWTL02.shhh.trim.unique.fasta $(MOTHUR)/HLFAWTL02.shhh.trim.unique.names $(MOTHUR)/HLFAWTL02.shhh.groups : code/get_denoised_data.sh $(RAW)/HLFAWTL02.sff $(RAW)/HLFAWTL02.oligos
	code/get_denoised_data.sh HLFAWTL02


# now we need to merge the fasta, group, and names files...
$(MOTHUR)/clinical.fasta : $(MOTHUR)/HD9SPZN01.shhh.trim.unique.fasta\
							$(MOTHUR)/HD7UIAO01.shhh.trim.unique.fasta\
							$(MOTHUR)/HJKE73L01.shhh.trim.unique.fasta\
							$(MOTHUR)/HLFAWTL01.shhh.trim.unique.fasta\
							$(MOTHUR)/HLFAWTL02.shhh.trim.unique.fasta
	cat $? > $@

$(MOTHUR)/clinical.names : $(MOTHUR)/HD9SPZN01.shhh.trim.unique.names\
							$(MOTHUR)/HD7UIAO01.shhh.trim.unique.names\
							$(MOTHUR)/HJKE73L01.shhh.trim.unique.names\
							$(MOTHUR)/HLFAWTL01.shhh.trim.unique.names\
							$(MOTHUR)/HLFAWTL02.shhh.trim.unique.names
	cat $? > $@

$(MOTHUR)/clinical.groups : $(MOTHUR)/HD9SPZN01.shhh.groups\
							$(MOTHUR)/HD7UIAO01.shhh.groups\
							$(MOTHUR)/HJKE73L01.shhh.groups\
							$(MOTHUR)/HLFAWTL01.shhh.groups\
							$(MOTHUR)/HLFAWTL02.shhh.groups
	cat $? | sed -e "s/\.2//" > $@


BASIC_STEM = $(MOTHUR)/clinical.unique.good.filter.unique.precluster


# here we go from the denoised fasta, names, and groups files to generate a
# fasta, taxonomy, and count_table file that has had the chimeras removed as
# well as any non bacterial sequences
$(BASIC_STEM).denovo.uchime.pick.pick.count_table $(BASIC_STEM).pick.pick.fasta $(BASIC_STEM).pick.v35.wang.pick.taxonomy : code/get_good_seqs.sh\
										$(MOTHUR)/clinical.fasta\
										$(MOTHUR)/clinical.groups\
										$(MOTHUR)/clinical.names\
										$(REFS)silva.v35.align\
										$(REFS)trainset18_062020.v35.fasta\
										$(REFS)trainset18_062020.v35.tax
	code/get_good_seqs.sh


# here we go from the good sequences and generate a shared file and a
# cons.taxonomy file based on OTU data
$(BASIC_STEM).pick.pick.pick.an.unique_list.shared $(BASIC_STEM).pick.pick.pick.an.unique_list.0.03.cons.taxonomy : code/get_shared_otus.sh\
										$(BASIC_STEM).denovo.uchime.pick.pick.count_table\
										$(BASIC_STEM).pick.pick.fasta\
										$(BASIC_STEM).pick.v35.wang.pick.taxonomy
	code/get_shared_otus.sh



# now we want to get the sequencing error as seen in the mock community samples
$(BASIC_STEM).pick.pick.pick.error.summary : code/get_error.sh\
										$(BASIC_STEM).denovo.uchime.pick.pick.count_table\
										$(BASIC_STEM).pick.pick.fasta\
										$(REFS)HMP_MOCK.v35.fasta
	code/get_error.sh



data/process/schubert.shared.gz: $(BASIC_STEM).pick.pick.pick.opti_mcc.shared
	gzip < $^ > $@

data/process/schubert.cons.taxonomy: $(BASIC_STEM).pick.pick.pick.opti_mcc.0.03.cons.taxonomy
	cp $^ $@

data/process/schubert.metadata.xlsx : $(RAW)/MIMARKS_cdclinical.xlsx
	cp $^ $@


################################################################################
#
#	Part 4: Write the paper
#
################################################################################
