import os,stat,time,datetime
from functools import reduce
lista = os.listdir()
lista_datos = []
for elem in lista:
    if os.path.isfile(elem):
        lista_total = list([elem,os.stat(elem).st_size,time.ctime(os.stat(elem).st_mtime),time.strptime(time.ctime(os.stat(elem).st_mtime))])
        print(lista_total[0]) #nombre del archivo
        print(lista_total[1]) #tamaño del archivo
        print(lista_total[2])  #fecha de su ultimo acceso
        print(lista_total[3])
    lista_datos.append(list(lista_total))
lista_mayus = list(map(lambda x: str(x[0]).capitalize() , lista_datos))
#print(lista_mayus)  
tam_total = list(map(lambda tam: tam[1] ,lista_datos))
#print (tam_total) 
suma = reduce(lambda x, y: x + y, tam_total)
#print(suma)
ahora = time.strftime("%c")
#print(ahora)
ahora = time.strptime(ahora)
print(ahora)
modificado_3dias= list(map(lambda x: (datetime.date(x[3][0],x[3][1],x[3][2])-datetime.date(ahora[0],ahora[1],ahora[2])).days < 3,lista_datos)) 
print(modificado_3dias)
lista_ordenado_tamaño = sorted(lista_datos, key=lambda tam: tam[1])
#print(lista_ordenado_tamaño)