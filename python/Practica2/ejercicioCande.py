import os
def leer_archivos():
    string= "./imagenes/"
    lista = os.listdir(string)
    print(lista)
    imagenes = {}
    for x in lista:
        if(os.path.isdir(string+x)):
            imagenes[x]= os.listdir(string+x)
    return imagenes
print(leer_archivos())