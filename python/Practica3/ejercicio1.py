import random
f = open('ejercicio1.txt','r')
string = f.read()
f.close()
string = string.split('/')
print(string)
colores = string[0].split('&')
coordenadas = string[1].split('&')
print(colores)
print(coordenadas)
diccionario={}
for clave in coordenadas:
    indice = random.randrange(5)
    diccionario[clave]=colores[indice]
print(diccionario)
diccionario2={}
for clave in coordenadas:
    indice = random.randrange(len(colores))
    diccionario[clave] = colores[indice]
    del colores[indice]
print(diccionario)