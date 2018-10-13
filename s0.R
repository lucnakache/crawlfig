rm(list=ls())

# Import des librairies
library(rvest)

# Chargement des fonctions
source(file = "C:/Users/Bar Yokhai/Desktop/projets/Blog/corpusvin/fun.R",encoding = "UTF-8")
source(file = "C:/Users/Bar Yokhai/Desktop/projets/Blog/corpusvin/funbis.R",encoding = "UTF-8")


# Metaparameters
folderdata = "C:/Users/Bar Yokhai/Desktop/projets/Blog/corpusvin/data/"
npagestocrawl = 702


# * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * * 


# STEP 0
# Construction de toutes les url "catalogue"
cat("\nSTEP 0 :")
urlpagecatalogue=paste0("http://avis-vin.lefigaro.fr/vins-champagne/explorer-les-vins/page/",seq(0,701))  


# STEP 1
# Construction de toutes les url vins + retouche
cat("\nSTEP 1 :")
urlwine=buildurlwine(urlpagecatalogue[1:npagestocrawl])



# STEP 2
# crawling des fiches produits + sauvegarde
cat("\nSTEP 2 :")
fiche_vin = extractingficheproduit(urlwine)
saveRDS(object =fiche_vin ,file = paste0(folderdata,"fiche_produit.rds"))



# STEP 3
# on ne garde que les url infos
cat("\nSTEP 3 :")
url_info = unique(unlist(lapply(fiche_vin,"[[","urlinfo")))



# STEP 4
cat("\nSTEP 4 :")
url_info_type = extract_info_type(url_info)


# STEP 5
cat("\nSTEP 5 :")
metadescriptions = retrievedescription(url_info,url_info_type)


# STEP 6
# Extraction du corpus pr vinouz+ export
cat("\nSTEP 6 :")
exportcorpus(metadescriptions,fiche_vin,folderdata)


# STEP 7
# description meta data dataframe
cat("\nSTEP 7 :")
metadescription_df = buildmetadescriptiondf(urlinfo,url_info_type,metadescriptions)
saveRDS(object = metadescription_df, file = paste0(folderdata,"metadescription_df.rds"))


# STEP 8
# fiche produit dataframe
cat("\nSTEP 8 :")
fiche_vin_df = buildfichevindf(fiche_vin,metadescription_df)
saveRDS(object = fiche_vin_df,file = paste0(folderdata,"fiche_vin_df.rds"))

