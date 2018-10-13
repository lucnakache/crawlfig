# Fonction qui a partir d une url de page catalogue retrieve toutes les url des vins
fun_retrieve_wine_url_from_page_catalogue = function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  urlpage <- apage %>% 
    html_nodes(".name") %>%
    html_attr("href")
  if (identical(urlpage,character(0))) {urlpage = NA}
  return(urlpage)
}

# Fonction qui a partir d'une url vin, crawl le nom du vin
# aurl = "http://avis-vin.lefigaro.fr/vins-champagne/bordeaux/rive-droite/saint-emilion-grand-cru/d20584-chateau-ausone/v20661-chateau-d-ausone/vin-rouge"
crawl_name_from_fiche=function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  namewine <- apage %>% 
    html_nodes(".col-md-push-4 .optima") %>%
    html_text()
  if (identical(namewine,character(0))) {namewine = NA}
  return(namewine)
}








# Fonctio a partir dune url vin xcrawl la description si elle existe
crawl_wine_description=function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  namewine <- apage %>% 
    html_nodes("#millesime-presentation p") %>%
    html_text()
  if (identical(namewine,character(0))) {namewine = NA}
  return (namewine)
}










# Fonction qui a partir d une url vin, crawl informations type 1
crawl_info_type_i=function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  namewine <- apage %>% 
    html_nodes(".info-vin a") %>%
    html_text()
  if (identical(namewine,character(0))) {namewine = NA}
  return (namewine)
}

# Fonction qui a partir d une url vin, crawl URL informations type 1
crawl_info_URL_type_i=function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  namewine <- apage %>% 
    html_nodes(".info-vin a") %>%
    html_attr("href")
  if (identical(namewine,character(0))) {namewine = NA}
  return (namewine)
}

# Fonction information de type 2
crawl_info_type_ii=function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  namewine <- apage %>% 
    html_nodes(".millesime-type a") %>%
    html_text()
  if (identical(namewine,character(0))) {namewine = NA}
  return (namewine)
}

# Fonction qui a partir d une url vin, crawl URL informations type 2
crawl_info_URL_type_ii=function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  namewine <- apage %>% 
    html_nodes(".millesime-type a") %>%
    html_attr("href")
  if (identical(namewine,character(0))) {namewine = NA}
  return (namewine)
}

# Fonction information de type 3
crawl_info_type_iii=function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  namewine <- apage %>% 
    html_nodes("#millesime-region a") %>%
    html_text()
  if (identical(namewine,character(0))) {namewine = NA}
  return (namewine)
}

# Fonction qui a partir d une url vin, crawl URL informations type 3
crawl_info_URL_type_iii=function(aurl){
  apage = read_html(aurl,encoding = "UTF-8")
  namewine <- apage %>% 
    html_nodes("#millesime-region a") %>%
    html_attr("href")
  if (identical(namewine,character(0))) {namewine = NA}
  return (namewine)
}


















# which type fonction
whichtypepage=function(aurl){
  produceur = isproducteur_from_url(aurl)
  cepage = iscepage_from_url(aurl)
  regionappel = isregionappellation_from_url(aurl)

  
  total = c(produceur,cepage,regionappel)
  
  type_page="notype"
  if (sum(total)==1 & which(total)==1){type_page="producteur"}
  if (sum(total)==1 & which(total)==2){type_page="cepage"}
  if (sum(total)==1 & which(total)==3){type_page="regionappel"}
  
  return(type_page)
}



# fonction isproducteur from url
isproducteur_from_url=function(aurl){
  decomposition = strsplit(x = aurl,split = "/",fixed = TRUE)[[1]]
  r = "vins-champagne" %in% decomposition
  return (r)
}

# fonction iscepage from url
iscepage_from_url=function(aurl){
  decomposition = strsplit(x = aurl,split = "/",fixed = TRUE)[[1]]
  r = "guide-des-cepages" %in% decomposition
  return (r)
}

# fonction isregionappellation from url
isregionappellation_from_url=function(aurl){
  decomposition = strsplit(x = aurl,split = "/",fixed = TRUE)[[1]]
  r = "guide-des-regions-et-des-appellations" %in% decomposition
  return (r)
}























# fonction qui crawl tt les url des fiches produit de vins
extractingficheproduit=function(urlwine){
  fiche_vin = lapply(seq_along(urlwine),function(x){
    
    
    tryCatch({
      
      
      
      # tracking des vins
      cat("\r vin °",x," sur ",length(urlwine))
      
      # Lecteur de la page url
      aurl = urlwine[x]
      apage = read_html(aurl,encoding = "UTF-8")
      

      
      # Nom du vin
      name <- apage %>% 
        html_nodes(".col-md-push-4 .optima") %>%
        html_text()
      if (identical(name,character(0))) {name = NA}
      
      # Description du vin ou pas
      description <- apage %>% 
        html_nodes("#millesime-presentation p") %>%
        html_text()
      if (identical(description,character(0))) {description = NA}
      
      
      # info type 1,2,3
      info1 <- apage %>% 
        html_nodes(".info-vin a") %>%
        html_text()
      if (identical(info1,character(0))) {info1 = NA}
      
      info2 <- apage %>% 
        html_nodes(".millesime-type a") %>%
        html_text()
      if (identical(info2,character(0))) {info2 = NA}
      
      info3 <- apage %>% 
        html_nodes("#millesime-region a") %>%
        html_text()
      if (identical(info3,character(0))) {info3 = NA}
      
      info = c(info1,info2,info3)
      
      # url info type 1,2,3
      urlinfo1 <- apage %>% 
        html_nodes(".info-vin a") %>%
        html_attr("href")
      if (identical(urlinfo1,character(0))) {urlinfo1 = NA}
      
      urlinfo2 <- apage %>% 
        html_nodes(".millesime-type a") %>%
        html_attr("href")
      if (identical(urlinfo2,character(0))) {urlinfo2 = NA}
      
      urlinfo3 <- apage %>% 
        html_nodes("#millesime-region a") %>%
        html_attr("href")
      if (identical(urlinfo3,character(0))) {urlinfo3 = NA}
      
      urlinfo = c(urlinfo1,urlinfo2,urlinfo3)
      
      
      # concatenation
      final_result = list()
      final_result[["nid"]] = x
      final_result[["url"]] = aurl
      final_result[["nom"]] = name
      final_result[["description"]] = description
      final_result[["info"]] = info
      final_result[["urlinfo"]] = paste0("http://avis-vin.lefigaro.fr",urlinfo)
      
      
      return(final_result)},error=function(cond) {
        return(NA)
      },
      finally = {}
    )
    
  })
  
  return(fiche_vin)
}






# Extract les info types d'un vecteur url info
extract_info_type=function(url_info){
  
  url_info_type = lapply(seq_along(url_info),function(x){
    
    tryCatch({
      
      cat("\r url n°",x," sur ", length(url_info))
      aurl = url_info[x]
      result = whichtypepage(aurl)
      return(result)},error=function(cond) {
        return(NA)
      },
      finally = {}
    )
  })
  
  return(url_info_type)
}

















extractdescription_fromurl_andtype=function(aurl,urltype){
  
  apage = read_html(aurl,encoding = "UTF-8")
  
  decription=""
  
  if (urltype=="producteur") {
    description <- apage %>% 
      html_nodes("#avis-figaro-html p") %>%
      html_text()
  }
  
  if (urltype=="cepage") {
    description <- apage %>% 
      html_nodes("#content p") %>%
      html_text()
  }
  if (urltype=="regionappel") {
    description <- apage %>% 
      html_nodes("#def p") %>%
      html_text()
  }
  
  
  if (identical(description,character(0))) {description = NA}
  
  return(description)
  
  
}














# apartir durl et url type extract tt les descriptions possibles
retrievedescription=function(url_info,url_info_type){
  metadescriptions = lapply(seq_along(url_info),function(x){
    
    tryCatch({
    
    cat("\r url info n°",x," sur ",length(url_info))
    
    aurl = url_info[x]
    urltype = url_info_type[x]
    resultat = extractdescription_fromurl_andtype(aurl,urltype)
    return(resultat)},error=function(cond) {
      return(NA)
    },
    finally = {}
    )
    
  })
  
  return(metadescriptions)
}










# fonction qui retrieve les url des fiche produit vin a partir des url des pages catalogue
buildurlwine = function(urlpagecatalogue){
  urlwine = lapply(seq_along(urlpagecatalogue),function(x){
    cat("\rPage n°",x," sur ",length(urlpagecatalogue))
    res = fun_retrieve_wine_url_from_page_catalogue(urlpagecatalogue[x])
    return(res)
  })
  urlwine = unlist(urlwine)
  urlwine = paste0("http://avis-vin.lefigaro.fr",urlwine)
  
  return(urlwine)
}