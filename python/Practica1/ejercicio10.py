diccionario={}
for i in range(5):
    nombre=input("Ingrese el nombre")
    nivel=int(input("Ingrese el nivel"))
    punt=int(input("Ingrese la puntuacion maxima"))
    tiempo=int(input("Ingrese el tiempo"))
    diccionario[nombre] = [nivel,punt,tiempo]
print(diccionario)
mayor = 0
for lis in diccionario:
    if diccionario[lis][1] > mayor:
        mayor = diccionario[lis][1]
        nombreMayor = lis;
        todoMayor= diccionario[lis]
print (todoMayor , nombreMayor)
