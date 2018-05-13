import csv

archi = open("Todas.las.carreras27032018.csv", "r")
csvreader = csv.reader(archi)
dic = {}
ok = False
for fila in csvreader:
    if not ok :
        ok = True
    else:
         universidad = fila[2]
         if(not universidad in dic):
            dic[universidad] = 0 
         tot = (0 if fila[10]=='' else fila[10])
         tot = int(tot)
         dic[universidad] = dic[universidad] + tot
print(dic)
