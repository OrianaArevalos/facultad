diccionario={}
for i in range(5):
    nombre=input("Ingrese el nombre")
    nivel=input("Ingrese el nivel")
    punt=input("Ingrese la puntuacion maxima")
    tiempo=input("Ingrese el tiempo")
    diccionario[nombre] = [nivel,punt,tiempo]
print(diccionario)
print(diccionario['pepe']);
#¿La eleccion sobre la estructura fue correcta? Si.
#¿Cuál uso? Usé un diccionario.
