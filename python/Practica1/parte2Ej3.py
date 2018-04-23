lista1 = ['perro', 4, True, (6,7)]
lista2 = [False, 'casa', 9, [3, 4, 'gato']]
lista3 = []
lista1.extend(lista2)
lista_aux = lista1
for elem in lista_aux:
    if type(elem) is str:
        lista3.append(elem)
print(lista3)