library(dplyr)
all_opportunities <- read.csv("Opportunities_2.csv", header=T,fill=T)
clusters_distances <- read.csv("Clusters_matrix.csv", header = FALSE, fill = T)
colnames(clusters_distances) <- rownames(clusters_distances)
#record_table <- data.frame(ncol(9))




match_applicant <- function(loc,background,is_entrepreneur,top_degree,job_readiness_level,english_level,digital_level,local_lan_level){
  best_opportunities <- NULL
  if (is_entrepreneur == 1) {
    best_opportunities <- all_opportunities[all_opportunities$Country %in% c(loc,'Global') & all_opportunities$Theme == 'entrepreneurship and incubation',]
  }
  else {
    best_opportunities <- all_opportunities[all_opportunities$Country %in% c(loc,'Global') & all_opportunities$Category == 'Job' & all_opportunities$Mode.of.Delivery != 'online' & all_opportunities$Cluster.nb == background & all_opportunities$Level <= job_readiness_level,]
    if (dim(best_opportunities)[1]  > 0) {
      if (dim(best_opportunities[best_opportunities$local_lan_requirements <= local_lan_level & best_opportunities$en_requirements <= english_level,])[1]>0){
        print("job found in location!")
        }
      else{
        print("applicant can find a job locally if he/she enhances his/her language skills") 
        best_opportunities <- all_opportunities[all_opportunities$Country %in% c(loc,'Global') & all_opportunities$Theme %in% c('integration','language education'),]
      }
    }
    else{
      best_opportunities <- all_opportunities[all_opportunities$Category == 'Job' & all_opportunities$Mode.of.Delivery == 'online' & all_opportunities$Country %in% c('Global',loc) & all_opportunities$Cluster.nb == background & all_opportunities$Level <= job_readiness_level,]
      if (dim(best_opportunities)[1] > 0) {
        print('online job found!')
        
        if (digital_level < 7) {
          print("applicant digital skills are not enough")
          best_opportunities <- all_opportunities[all_opportunities$Country %in%  c(loc,'Global') & all_opportunities$Theme == 'Digital education' & all_opportunities$Mode.of.Delivery != 'online',]
        }
        
        if (english_level < 7) {
          print("applicant english level is not enough")
          best_opportunities <- all_opportunities[all_opportunities$Country %in%  c(loc,'Global') & all_opportunities$Theme == 'English education',]
        }
        
      }
      
      else{
        print('no Job found')
        if (top_degree =='none') {
          print('applicant needs university education')
          education_opportunities <- all_opportunities[all_opportunities$Country %in% c(loc,'Global') & all_opportunities$Category == 'University Degree' & all_opportunities$Level == 1,]
          best_opportunities <- education_opportunities
        }
        else{
          print('applicant needs trainings or superior university education')
          training_opportunities <- find_trainings(loc,background,english_level,digital_level,local_lan_level)
          best_opportunities <- training_opportunities
        }
      }
      
      
    }
  }
  
  print_results(best_opportunities)
  
}


find_trainings <- function(loc,background,english_level,digital_level,local_lan_level){
  best_training_opportunities <- NULL
  onsite_training_opportunities <- all_opportunities[all_opportunities$Category != 'Job' & all_opportunities$Country %in% c(loc,'Global') & all_opportunities$Mode.of.Delivery != 'online' & all_opportunities$Theme != 'entrepreneurship and incubation',]
  if (dim(onsite_training_opportunities)[1] > 0) {
    if (dim(onsite_training_opportunities[onsite_training_opportunities$en_requirements <= english_level & onsite_training_opportunities$local_lan_requirements <= local_lan_level,])[1]>0) {
      print("training opportunity found in location!")
      best_training_opportunities <- onsite_training_opportunities[distance(as.vector(onsite_training_opportunities$Cluster.nb),background) <= 0.2 & onsite_training_opportunities$Level != 1,]
      if (dim(best_training_opportunities)[1] > 0){
        print('training opportunity suitable to background found')
      }
      else{
        best_training_opportunities <- onsite_training_opportunities[onsite_training_opportunities$Level == 1 & onsite_training_opportunities$Category != 'University Degree',]
        print("trainings in different domains but with basic entry requirements are suggested")
        if (unique(best_training_opportunities$Theme) == 'integration'){
          complementary_trainings <- find_online_trainings(background)
          best_training_opportunities <- rbind(best_training_opportunities,complementary_trainings)
        }
      }
    }
    else{
      print("applicant can find a training locally if he/she enhances his/her language skills") 
      best_training_opportunities <- all_opportunities[all_opportunities$Country %in% c(loc,'Global') & all_opportunities$Theme %in% c('integration','language education'),]
    }
  }
  else {
    if (digital_level >= 7 & english_level >= 7) {
      print('find online trainings')
      best_training_opportunities <- find_online_trainings(background)
    }
    else{
      print("applicant digital and english skills are not enough for online trainings")
      best_training_opportunities <- all_opportunities[all_opportunities$Country == loc & all_opportunities$Theme %in% c('Digital education','English education'),]  
    }
  }
  
  return(best_training_opportunities)
}


find_online_trainings <- function(background){
  best_training_opportunities <- NULL
  online_training_opportunities <- all_opportunities[all_opportunities$Category != 'Job' & all_opportunities$Country %in% c(loc,'Global') & all_opportunities$Mode.of.Delivery == 'online',]
  if (dim(online_training_opportunities)[1] > 0) {
    print("training opportunity found online!")
    best_training_opportunities <- online_training_opportunities[distance(as.vector(online_training_opportunities$Cluster.nb),background) <= 0.2 & online_training_opportunities$Level != 1,]
    if (dim(best_training_opportunities)[1] > 0){
      print('medium and advanced trainings related to background found')
    }
    else{
      print('trainings in different domains but with basic entry requirements are suggested')
      best_training_opportunities <- online_training_opportunities[online_training_opportunities$Level == 1 & online_training_opportunities$Category != 'University Education', ]
    }
  }
  else {
    print('No online trainings found :(')
  }
  return(best_training_opportunities)
  
}


distance <- function(cluster_id_1,cluster_id_2){
  distance_clusters <- clusters_distances[cluster_id_1,cluster_id_2]
  return(distance_clusters)
}


print_results <- function(opportunities_table){
  if (dim(opportunities_table)[1] == 0){
    cat("we are sorry. we could not find any suitable opportunities for your profile")
  }
  else{
    for (i in 1:dim(opportunities_table)[1]){
      cat(paste0("we suggest an ",opportunities_table[i,3]," ",opportunities_table[i,4]," related ",opportunities_table[i,2]," opportunity provided by ",opportunities_table[i,1]))
      cat("\n")
      cat(paste0("More info can be found here: ",opportunities_table[i,10]))
      cat("\n")
      cat("\n")
      i <- i+1
    }
    cat("if you have questions or need a mentor to guide you through the application process, contact us at contact@rafiqi.net")
  }
}


transform_country_input <- function(country){
  if (country == 1) {return("Netherlands")}
  if (country == 2) {return("France")}
  if (country == 3) {return("Germany")}
  if (country == 4) {return("Jordan")}
  if (country == 5) {return("Switzerland")}
  if (country == 6) {return("UK")}
  if (country == 7) {return("Sweden")}
  if (country == 8) {return("Spain")}
  if (country == 9) {return("Denmark")}
 
}

transform_degree_input <- function(degree){
  if (degree == 1) {return("bachelor")}
  if (degree == 2) {return("associate")}
  if (degree == 3) {return("masters")}
  if (degree == 4) {return("none")}
}

transform_entrepreneur_input <- function(entrepreneur){
  if (entrepreneur== TRUE) {return(1)}
  else {return(0)}
}


process_inputs <- function(country,degree,entrepreneur,background_id,job_readiness, en_level,loc_language_level,digital){
  new_country <- transform_country_input(country)
  new_degree <- transform_degree_input(degree)
  new_entrepreneur <- transform_entrepreneur_input(entrepreneur)
  match_applicant(new_country,background_id, new_entrepreneur ,new_degree,job_readiness,en_level,digital,loc_language_level)
}

#collect_record <- function(country,degree,entrepreneur,background_id,job_readiness, en_level,loc_language_level,digital,feedback){
 # new_record <- c(country,degree,entrepreneur,background_id,job_readiness, en_level,loc_language_level,digital,feedback)
#  record_table <- rbind(record_table,new_record)
 #}

