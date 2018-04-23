from pattern.es import attributive, predicative
from pattern.es import FEMALE, PLURAL 
  
print (predicative('curiosos')) 
print (attributive('curioso', gender=FEMALE))
print (attributive('curioso', gender=FEMALE+PLURAL))