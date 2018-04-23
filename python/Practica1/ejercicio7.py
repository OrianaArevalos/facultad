diccionario={}
for i in range(5):
    nombre=input("Ingrese el nombre")
    nivel=int(input("Ingrese el nivel"))
    punt=int(input("Ingrese la puntuacion maxima"))
    tiempo=int(input("Ingrese el tiempo"))
    diccionario[nombre] = [nivel,punt,tiempo]
print(diccionario)
#es mejor usar un dic.
