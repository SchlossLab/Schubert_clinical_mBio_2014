Microbiome data distinguish patients with *Clostridium difficile* infection and non-*C. difficile*-associated diarrhea from healthy controls.
=======

Antibiotic usage is the most commonly cited risk factor for hospital-acquired Clostridium difficile infections (CDI). The increased risk is due to disruption of the indigenous microbiome and a subsequent decrease in colonization resistance by the perturbed bacterial community; however, the specific changes in the microbiome that lead to increased risk are poorly understood. We developed statistical models that incorporated microbiome data with clinical and demographic data to better understand why individuals develop CDI. The 16S rRNA genes were sequenced from the feces of 338 individuals, including cases, diarrheal controls, and nondiarrheal controls. We modeled CDI and diarrheal status using multiple clinical variables, including age, antibiotic use, antacid use, and other known risk factors using logit regression. This base model was compared to models that incorporated microbiome data, using diversity metrics, community types, or specific bacterial populations, to identify characteristics of the microbiome associated with CDI susceptibility or resistance. The addition of microbiome data significantly improved our ability to distinguish CDI status when comparing cases or diarrheal controls to nondiarrheal controls. However, only when we assigned samples to community types was it possible to differentiate cases from diarrheal controls. Several bacterial species within the Ruminococcaceae, Lachnospiraceae, Bacteroides, and Porphyromonadaceae were largely absent in cases and highly associated with nondiarrheal controls. The improved discriminatory ability of our microbiome-based models confirms the theory that factors affecting the microbiome influence CDI.




Overview
--------

    project
    |- README          # the top level description of content
    |
    |- doc/            # documentation for the study
    |  |- notebook/    # preliminary analyses (dead branches of analysis)
    |  +- paper/       # manuscript(s), whether generated or not
    |
    |- data            # raw and primary data, are not changed once created
    |  |- references/  # reference files to be used in analysis
    |  |- raw/         # raw data, will not be altered
    |  |- mothur/      # mothur processed data
    |  +- process/     # cleaned data, will not be altered once created;
    |                  # will be committed to repo
    |
    |- code/           # any programmatic code
    |- results         # all output from workflows and analyses
    |  |- tables/      # text version of tables to be rendered with kable in R
    |  |- figures/     # graphs, likely designated for manuscript figures
    |  +- pictures/    # diagrams, images, and other non-graph graphics
    |
    |- scratch/        # temporary files that can be safely deleted or lost
    |
    |- study.Rmd       # executable Rmarkdown for this study, if applicable
    |- study.md        # Markdown (GitHub) version of the *Rmd file
    |- study.html      # HTML version of *.Rmd file
    |
    +- Makefile        # executable Makefile for this study, if applicable
