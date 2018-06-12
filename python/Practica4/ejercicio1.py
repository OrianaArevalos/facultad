import random
colores = ['azul','amarillo','rojo','blanco','negro']
coordenadas = [(2,3),(5,6),(8,8),(10,2),(-5,-8)]
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
def asociaciones(diccionario):
    try:
        coorXY = (int(input("Ingrese la coordenada x")), int(input("Ingrese la coordenada y")))
        return(diccionario[coorXY])
    except (KeyError):
        print("Ingrese de nuevo las coordenadas")
        return asociaciones(diccionario)
print(asociaciones(diccionario))
