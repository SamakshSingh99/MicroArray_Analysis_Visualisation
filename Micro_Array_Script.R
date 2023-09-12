################################################################
# Script to perform MicroArray Data analysis and Visualisation #
# Data used ~ GSE56133 (sourced from Gene Expression Omnibus)  #
# File format .CEL type                                        #
################################################################

###########################
# INDEX                   #
# 1. Downloading Packages #
# 2. Loading Packages     #
# 3. Reading .CEL file    #
# 4. Data Normalisation   #
# 5. EDA                  #
# 6. Getting Expression   #
#    Estimates            #
# 7. Generating Metadata  #
# 8. Reshaping Expression #
#    Data                 #
# 9. Data Visualisation   #
###########################

##########################
## Downloading Packages ##
##########################

BiocManager::install("affy", force = T)
BiocManager::install("affycoretools", force = T)
BiocManager::install("affyPLM", force = T)
BiocManager::install("GEOquery")
BiocManager::install("pcaMethods")

###################
## Load Packages ##
###################

library('affy') # version 1.78.2
library('affyPLM') # version 1.76.1
library('affycoretools') # version 1.72.0
library('GEOquery') # version 2.68.0
library('tidyverse') # version 2.0.0
library('ggplot2') # version 3.4.3
library('pcaMethods') # version 1.92.0
library('limma') # version 3.56.2

###########################
## Set working directory ##
###########################
setwd("D:/MY REPOS/Ecoli_WT_Untreated_vs_Treated")

getGEOSuppFiles("GSE56133") # installing RMA supplementary file from Gene expression Omnibus

untar("GSE56133/GSE56133_RAW.tar", exdir = "./Data")

#######################
## Reading .cel file ##
#######################

Data <- ReadAffy(celfile.path = './Data/')

# AffyBatch object
# size of arrays=478x478 features (28 kb)
# cdf=E_coli_2 (10208 affyids)
# number of samples=27
# number of genes=10208
# annotation=ecoli2
# notes=

hist(Data)

boxplot(Data)

#image(Data)

#######################
## RMA Normalisation ##
#######################

# using RMA method
RMA.Norm <- rma(Data)

# ExpressionSet (storageMode: lockedEnvironment)
# assayData: 10208 features, 27 samples 
# element names: exprs 
# protocolData
# sampleNames: GSM1356325_WT_Untreated_1.CEL.gz GSM1356326_WT_Untreated_2.CEL.gz ...
# GSM1356351_Hpx_KO_Untreated_3.CEL.gz (27 total)
# varLabels: ScanDate
# varMetadata: labelDescription
# phenoData
# sampleNames: GSM1356325_WT_Untreated_1.CEL.gz GSM1356326_WT_Untreated_2.CEL.gz ...
# GSM1356351_Hpx_KO_Untreated_3.CEL.gz (27 total)
# varLabels: sample
# varMetadata: labelDescription
# featureData: none
# experimentData: use 'experimentData(object)'
# Annotation: ecoli2

# using MAS5 method

MAS5.Norm <- mas5(Data)

# ExpressionSet (storageMode: lockedEnvironment)
# assayData: 10208 features, 27 samples 
# element names: exprs, se.exprs 
# protocolData
# sampleNames: GSM1356325_WT_Untreated_1.CEL.gz GSM1356326_WT_Untreated_2.CEL.gz ...
# GSM1356351_Hpx_KO_Untreated_3.CEL.gz (27 total)
# varLabels: ScanDate
# varMetadata: labelDescription
# phenoData
# sampleNames: GSM1356325_WT_Untreated_1.CEL.gz GSM1356326_WT_Untreated_2.CEL.gz ...
# GSM1356351_Hpx_KO_Untreated_3.CEL.gz (27 total)
# varLabels: sample
# varMetadata: labelDescription
# featureData: none
# experimentData: use 'experimentData(object)'
# Annotation: ecoli2 

#########
## EDA ##
#########


# Boxplot
boxplot(exprs(RMA.Norm))

boxplot(exprs(MAS5.Norm))

#PCA Plots
plotPCA(RMA.Norm, groups = as.numeric(pData(Data)[,1]), groupnames =
          levels(pData(Data)[,1]))

##################################
## Getting expression estimates ##
##################################

Data.expression <- as.data.frame(exprs(RMA.Norm))

################
## Annotation ##
################

featureData <- GSE$GSE56133_series_matrix.txt.gz@featureData@data

# subset gene symbols #

featureData <- featureData[, c(1,12)]

##############################
# Generating Expression Data #
##############################

Data.expression <- Data.expression %>% 
  rownames_to_column(var = 'ID') %>%
  inner_join(., featureData, by = 'ID')


#########################
## Generating Metadata ##
#########################

GSE <- getGEO("GSE56133", GSEMatrix = T)

metadata <- pData(phenoData(GSE[[1]]))

Met_sub <- select(metadata, c(1, 10, 11, 22, 2))

data_mod <- metadata %>% select(1, 10, 11, 22, 2) %>%
  rename(genotype = characteristics_ch1) %>%
  rename(treatment = characteristics_ch1.1) %>%
  mutate(genotype = gsub("genotype: ", "", genotype)) %>%
  mutate(treatment = gsub("treatment: ", "", treatment)) %>%
  rename(GSM = geo_accession)

head(data_mod)

#############################
# reshaping expression data #
#############################

long_data <- Data.expression[,2:29] %>% 
  rename(gene = `Gene Symbol`) %>%
  gather(key = 'samples', value = 'FPKM', -gene)

# Creating a new column with respective GSM IDs 
long_data$GSM <- gsub("^(GSM\\d+)_.*", "\\1", long_data$samples)

##################################
# Joining long_data and data_mod #
##################################

long_data <- long_data %>%
  left_join(., data_mod, by = c("GSM"))

# Data Exploration #
long_data %>% 
  filter(gene == 'mutS' | gene == 'oxyR') %>%
  group_by(gene, treatment) %>%
  summarise(mean_FPKM = mean(FPKM), 
            median_FPKM = median(FPKM)) %>%
  arrange(-mean_FPKM)

 ######################
# Data Visualisation #
######################

# Barplot visualising changes in FPKM values for mutS #

long_data %>% 
  filter(gene == "mutS") %>%
  ggplot(., aes(x = treatment, y = FPKM, fill = treatment)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Density Plot

long_data %>% 
  filter(gene == 'mutS') %>% 
  ggplot(., aes(x = FPKM, color = treatment)) +
  geom_density(alpha = 1)

# Box Plot

long_data %>%
  filter(gene == 'mutS') %>%
  ggplot(., aes(x = treatment, y = FPKM, fill = treatment)) +
  geom_boxplot(alpha = 0.5) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Heat map

# 
Interest_Genes <- c('mutS', 'mrr', 'ggt', 'ycfK', 'yfbN', 'c4728')

long_data %>%
  filter(gene %in% Interest_Genes) %>%
  ggplot(., aes(x = treatment, y = gene, fill = FPKM)) +
  geom_tile() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_gradient(low = 'yellow', high = 'red')
  







