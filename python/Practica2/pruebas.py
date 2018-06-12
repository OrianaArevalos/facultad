import json
import csv
archi = open("pepetito.txt","w") 
csv.writer(archi,["hola","como","andas","pepe"])
archi.close()