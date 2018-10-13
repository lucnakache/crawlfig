# Crawler avis vins Le Figaro

### Objectif du repo
L'objectif est de crawler les informations basiques contenues sur le site avis vins figaro . fr. 

### Lancer le crawler
Pour lancer le crawler, lancez main.R.

### Parameters
Les meta parameters à changer sont présents dans le fichier main.R et s0.R. Il s'agit uniquement de l'adresse du dossier receptionnant les données ainsi que l'adresse du script s0.R.

### Données crawlées
Les données crawlées se trouvent dans le dossier data.
* corpus.text : concerne tous les articles qui décrivent un vin, un cépage, une région, une sous région ou une appellation. Il y a 19,000 articles.
* fiche_vin.rds : est une liste qui contient toutes les données des 12,000 fiches de vins crawlées
* fiche_produit.rds : est un dataframe qui contient les 12,000 fiches produits organisées de manière structurée
* metadescription_df.rds : est un dataframe qui contient toutes les descriptions concernant les régions, sous régions, cépages et appellations

