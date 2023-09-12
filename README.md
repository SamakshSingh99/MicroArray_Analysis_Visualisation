# MicroArray_Analysis_Visualisation
This repository contains a script for performing MicroArray data analysis and visualization using R. The data used in this script is sourced from Gene Expression Omnibus (GEO) and is provided in .CEL file format (Affymetrix GeneChip).

## Data
* Data was obtained from Gene Expression Omnibus database (__accession ID:__ GSE56133).
* __Platform Organism:__ *Escherichia coli*
* __Experiment type:__ Expression profiling by array
* __Data Format:__ .CEL
* __Overall design:__	WT or mutant *E coli* cells were grown to OD ~0.3. Untreated cells were harvested at time 0 as controls. Treated cells given the appropriate chemical perturbation and harvested 1 hour post-treatment. All experiments were performed in technical triplicate.

__Reference:__
Dwyer DJ, Belenky PA, Yang JH, MacDonald IC, Martell JD, Takahashi N, Chan CT, Lobritz MA, Braff D, Schwarz EG, Ye JD, Pati M, Vercruysse M, Ralifo PS, Allison KR, Khalil AS, Ting AY, Walker GC, Collins JJ. Antibiotics induce redox-related physiological alterations as part of their lethality. Proc Natl Acad Sci U S A. 2014 May 20;111(20):E2100-9. doi: 10.1073/pnas.1401876111. Epub 2014 May 6. PMID: 24803433; PMCID: PMC4034191. 

## Packages
* affy (version 1.78.2)
* affyPLM (version 1.76.1)
* affycoretools (version 1.72.0)
* GEOquery (version 2.68.0)
* tidyverse (version 2.0.0)
* ggplot2 (ersion 3.4.3)
* pcaMethods (version 1.92.0)
* limma (version 3.56.2)

### Package Installation
Make sure to install the necessary packages.
```R
BiocManager::install("affy", force = T)
BiocManager::install("affycoretools", force = T)
BiocManager::install("affyPLM", force = T)
BiocManager::install("GEOquery")
BiocManager::install("pcaMethods")
```
## Data Normalisation
* The script performs two types of data normalisation: RMA (Robust Multi-array Average) and MAS5 (MicroArray Suite 5).
* Normalisation is essential to ensure that the data is comparable and suitable for downstream analysis.

## Exploratory Data Analysis (EDA)
* Histogram was generated for each samples in the dataset

![image](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/853094e9-a21d-4281-b57c-bf3b4bfc36b7)
Fig : Sample-wise histogram

* Boxplots are used to visualize the distribution of expression values after normalisation.

![image](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/c6f862fc-8f69-43ac-af38-b89a7a6e09f5)
Fig : Before Normalisation

![image](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/2993de31-1032-4e88-be0e-f4f4b5a1d669)
Fig : After Normalisation

