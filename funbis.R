# fonction qui exporte le corpus
exportcorpus=function(metadescriptions,fiche_vin,folderdata){
  corpus1 = unlist(metadescriptions)
  corpus2 = unlist(lapply(fiche_vin,"[[","description"))
  corpusall = c(corpus1,corpus2)
  corpusall = corpusall[!is.na(corpusall)]
  fileConn<-file(paste0(folderdata,"corpus.txt"))
  writeLines(corpusall, fileConn)
  close(fileConn)
  return()
}













# fonction qui buold les metadescription dataframe
buildmetadescriptiondf=function(urlinfo,url_info_type,metadescriptions){
  metadescription_df = data.frame("urlinfo" = unlist(url_info),
                                  "urlinfotype" = unlist(url_info_type),
                                  "description" = unlist(lapply(metadescriptions,function(x){
                                    r = paste0(x,collapse="\n")
                                    return(r)
                                  })),stringsAsFactors = FALSE)
  metadescription_df$description = ifelse(metadescription_df$description=="NA",yes =NA ,no = metadescription_df$description)
  metadescription_df = metadescription_df[metadescription_df$urlinfo!="http://avis-vin.lefigaro.frNA",]
  
  
  
  special_key_to_replace =lapply( metadescription_df$urlinfo[metadescription_df$urlinfotype=="regionappel"],function(x){
    
    tryCatch({
      
      
      res = strsplit(x =x ,split = "/",fixed = T)[[1]]
      start = which(res=="guide-des-regions-et-des-appellations") + 1
      end = length(res)
      final = res[start:end]
      lastitem= final[length(final)]
      lastwords = strsplit(lastitem,split = "-",fixed = T)[[1]]
      if ("appellation" %in% lastwords) {
        key="appellation"
      } else if(length(final)>1){
        key="sous region"
      } else {
        key = "region"
      } 
      return(key)},error=function(cond) {
        return(NA)
      },
      finally = {}
    )
    
  })
  metadescription_df$key = metadescription_df$urlinfotype
  special_key_to_replace = unlist(special_key_to_replace)
  metadescription_df$key[metadescription_df$key=="regionappel" & !is.na(metadescription_df$key)] = special_key_to_replace[!is.na(special_key_to_replace)]
  
  
  
  return(metadescription_df)
  
}

















# fonction qui build la fiche de vin dataframe
buildfichevindf = function(fiche_vin,metadescription_df){
  fiche_vin_df = lapply(seq_along(fiche_vin),function(x){
    cat("\rfiche produit n°",x," sur ",length(fiche_vin))
    ficheproduit = fiche_vin[[x]]
    df = data.frame("nid" = ficheproduit$nid,
                    "url" = ficheproduit$url,
                    "name" = ficheproduit$nom,
                    "value" = ficheproduit$info,
                    "urlvalue" = ficheproduit$urlinfo,
                    stringsAsFactors = FALSE)
    return(df)
  })
  fiche_vin_df = do.call("rbind",fiche_vin_df)
  fiche_vin_df = fiche_vin_df[fiche_vin_df$urlvalue!='http://avis-vin.lefigaro.frNA',]
  
  # STEP9
  fiche_vin_df = merge(x = fiche_vin_df,
                       y= metadescription_df[,c("urlinfo","key")],
                       by.x = "urlvalue",
                       by.y = "urlinfo",
                       all.x=TRUE)
  
  fiche_vin_df = fiche_vin_df[order(fiche_vin_df$url),]
  return(fiche_vin_df)
}