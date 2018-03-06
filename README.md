The Rafiqi matching algo consists of a decision tree taking elements of refugee data such as refugee location, work/study background,language and digital level as tree nodes and different opportunities such as jobs, trainings, university degrees as tree leaves.

The tree is currently hard coded and reflects a logic inspired by on-the-ground experiments. However, the long term goal
is to feed feedbacks from matchings happening through the platform to the algo and make it dynamic and self-shaped.
Below is the main reasoning behind the decision tree (most of the possible scenarios are covered):

------------------------------------------------------------------------------------------------------------------------------
If refugee is an entrepreneur ->  CHOICE 1: match to entrepreneurship and incubation related opportunities in location

If none is found in location -> CHOICE 2: match to online programs related to entrepreneurship and incubation

If refugee is looking for a job -> if his/her level of job readiness is high -> if language level inline with job requirements ->CHOICE 3: match to jobs in location that require a similar work background 
     
 if no onsite jobs founds ->if english level and digital level are high enough ->CHOICE 4: match to online jobs that require a similar work background
           
   if no related online jobs found -> if refugee has at least a bachelor degree -> CHOICE 5: match to trainings or graduate degrees in location in domains considered as the closest to his/her background
                    
  if no onsite trainings in a domain close to refugee background found ->
         CHOICE 6: match to onsite trainings with basic entry level in popular domains (domains where there is demand)
                         
                         
   if no onsite trainings found ->
         CHOICE 7: match to online trainings closest to refugee work/study background
                              
                              
   if no online trainings close to background found ->
        CHOICE 8: match to online trainings with basic entry requirements and high popularity
                              

if refugee is looking for job->
if job readiness is low ->
Go to CHOICE 5 directly and proceed from there

if language level is not enough -> 
CHOICE 9: match to language and integration trainings in location

if english level is not enough -> 
CHOICE 10: match to english trainings in location or online
       
       
if digital level is not enough ->
CHOICE 11: match to digital education trainings onsite

if jobs not found and refugee has no bachelor ->
CHOICE 12: match to bachelor degree programs in location 
  
  
  if no bachelor degree programs found in location ->
   CHOICE 13: match to online universities
   
   
   --------------------------------------------------------------------------------------------------------------------------
 
  
 
  
  
  
  
       
                              
                           
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                
                              
                              
                                               

 
