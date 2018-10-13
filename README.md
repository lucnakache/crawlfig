# Crawler les fiches vins du site LeFigaro

### Objectif du repo
L'objectif est de crawler les informations basiques contenues sur le site http://avis-vin.lefigaro.fr/

### Processus
* Le fichier main.R lance le crawling via le script s0.R
* s0.R charge les fonctions contenues dans les fichiers fun.R et funbis.R
* Les données récoltées sont enregistrées dans le dossier data

### Parameters
Les meta parameters à changer sont présents dans le fichier main.R et s0.R. Il s'agit uniquement de l'adresse du dossier receptionnant les données ainsi que l'adresse du script s0.R.

### Données crawlées
Les données crawlées se trouvent dans le dossier data.
* corpus.text : concerne tous les articles qui décrivent un vin, un cépage, une région, une sous région ou une appellation. Il y a 19,000 articles.
* fiche_vin.rds : est une liste qui contient toutes les données des 12,000 fiches de vins crawlées
* fiche_produit.rds : est un dataframe qui contient les 12,000 fiches produits organisées de manière structurée
* metadescription_df.rds : est un dataframe qui contient toutes les descriptions concernant les régions, sous régions, cépages et appellations

