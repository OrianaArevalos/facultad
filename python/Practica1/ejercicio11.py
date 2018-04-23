diccionario={}
for i in range(5):
    nombre=input("Ingrese el nombre")
    nivel=int(input("Ingrese el nivel"))
    punt=int(input("Ingrese la puntuacion maxima"))
    tiempo=int(input("Ingrese el tiempo"))
    diccionario[nombre] = [nivel,punt,tiempo]
print(diccionario)
print("Ingrese un usuario")
nombre=input("Ingrese el nombre")
nivel=int(input("Ingrese el nivel"))
punt=int(input("Ingrese la puntuacion maxima"))
tiempo=int(input("Ingrese el tiempo"))
ok = False
#num=0
datos = [nivel,punt,tiempo]
#lista=diccionario.keys()
#while (ok != True) and (num < len(diccionario)):
for clave in diccionario:
    if (not ok):
        if diccionario[clave]== nombre:
                if (diccionario[clave][1]) < punt:
                    diccionario[clave]= datos
                    ok=True
                    print("El usuario fue modificado")
                else:
                    print("El usuario está en la lista pero no se modifico")
                    ok=True
if (ok == False):
    diccionario[nombre] = datos
    print("El usuario fue agregado a la lista, no estaba anteriormente")
print(diccionario)

lista=[];
for clave in diccionario:
    lista.append(diccionario[clave][1])
lista.sort(reverse=True)
print(lista)
i = 0
while (i != len(lista)) and (i < 10):
    print (i+1,'°-',lista[i])
    i=i+1
#ordenar el diccionario por puntaje
