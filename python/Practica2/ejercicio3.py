def imprimir_10_mejores():
    lista_puntajes = []
    for x in diccionario:
        lista_puntajes.append(diccionario[x][1])
    lista_puntajes.sort(reverse = False)
    i = 0
    while ((i < 10) and (i < len(lista_puntajes))):
        print(lista_puntajes[i])
        i = i+1
def imprimir_usuarios():
    for x in sorted(diccionario):
        print (x)
        print (diccionario[x][0], diccionario[x][1], diccionario[x][1])
def imprimir_nivel():
    dic2 = {}
    for x in diccionario:
        dic2[diccionario[x][0]] = [x,diccionario[x][1], diccionario[x][2]]
    for x in sorted(dic2):
        print(x,dic2[x][0],dic2[x][1],dic2[x][2])
diccionario={}
for i in range(5):
    nombre=input("Ingrese el nombre")
    nivel=int(input("Ingrese el nivel"))
    punt=int(input("Ingrese la puntuacion maxima"))
    tiempo=int(input("Ingrese el tiempo"))
    diccionario[nombre] = [nivel,punt,tiempo]
print(diccionario)
imprimir_10_mejores()
imprimir_usuarios()
imprimir_nivel()