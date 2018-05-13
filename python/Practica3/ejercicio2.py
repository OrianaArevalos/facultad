import random
def leerCoordenadas():
    num = int(input("Ingrese la cantidad de coordenadas que va a ingresar"))
    archivo = open("archivoCoord.txt", "a")
    archivoCo = open("archivoColore.txt","r")
    colores = archivoCo.read()
    lisColores = colores.split("&")
    lisCoordenadas = []
    diccionario={}
    for x in range(num):
        coordenada = str((int(input("Ingrese la coordenada x")),int(input("Ingrese la coordenada y"))))
        archivo.write(coordenada)
        lisCoordenadas.append(coordenada)
    for clave in lisCoordenadas:
         indice = random.randrange(5)
         diccionario[clave]=lisColores[indice]
    return(diccionario)
def escribirArchivo(dic):
    archivoT = open("ArchivoColoresCoordenadas.txt", "a")
    for clave in dic:
        archivoT.write(clave)
        archivoT.write("&")
        archivoT.write(dic[clave])
        archivoT.write("/")
parametro = leerCoordenadas()
escribirArchivo(parametro)