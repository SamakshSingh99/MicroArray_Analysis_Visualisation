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
* Histogram and PCA plot was generated to observe distribution of each samples in the dataset
  
![PCA_Plot](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/d63710f1-989a-4f71-91ad-f8922f3e2e55)

Fig : *__PCA Plot__*

![Density_Histogram_Affy Data](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/6c1bee14-547b-42ee-857a-0ce55bd671a8)

Fig :*__Sample-wise histogram__*

* Boxplots are used to visualize the distribution of expression values after normalisation.

![Unormalised_data_Boxplot](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/0f796865-54fd-4cac-890e-045d55b7953f)

Fig : *__Before Normalisation__*

![RMA_norm_Boxplot](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/1c018810-f0d9-4d61-8af7-bf4752cc794d)

Fig : *__After Normalisation__*

## Expression Estimates
The script extracts expression estimates from the normalized data, making it ready for further analysis.

## Generating Metadata
Metadata related to the samples is generated and processed for analysis. This includes information about genotype and treatment conditions.

## Reshaping Expression Data
* Expression data is reshaped to create a long-format dataset, making it suitable for visualization and analysis.
* This reshaped data includes information about gene expression levels (FPKM) for specific genes and the corresponding treatment conditions.

  ## Data Visualisation
  Several types of data visualisations are performed
  * __Barplot:__ Visualises changes in FPKM values for the "mutS" gene across different treatment conditions.
    
![Barplot_Treatment_Effect_on_mutS](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/aa4dd8f5-db8d-4078-bc4e-cb46fe655f1d)

Fig : *__FPKM changes for mutS gene across different treatment conditions (Bar plot)__*

  * __Density Plot:__ Shows the distribution of FPKM values for the "mutS" gene, with different colors representing treatment conditions.
    
![Density_Plot_muts_FPKM](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/031bca47-d5a3-46d9-9cd7-d97d4550be66)

Fig : *__Distribution of FPKM values for the mutS gene across different treatment (Density Plot)__*

  * __Box Plot:__ Visualises the distribution of FPKM values for the "mutS" gene, again considering treatment conditions.
    
![Boxplot](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/3acbf51c-62e8-48ad-bb09-b6dc27dd1373)

Fig : *__Distribution of FPKM values for the mutS gene across different treatment (Box Plot)__*

  * __Heatmap:__ Displays FPKM values for a set of selected genes (e.g., "mutS," "mrr," "ggt," etc.) across treatment conditions, using color gradients to represent expression levels.
    
![Heatmap_2](https://github.com/SamakshSingh99/MicroArray_Analysis_Visualisation/assets/130667983/8082957e-559b-4e96-9e1c-2e2f408733ff)

Fig : *__Expression levels of genes across treatment condition (Heatmap)__*

    
## Conclusion
Overall, this script offers a comprehensive analysis and visualization pipeline for MicroArray data, enabling researchers to explore gene expression patterns and make meaningful biological inferences.
