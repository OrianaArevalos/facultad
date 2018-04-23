frase = 'hola como andas, chau chau chau'
cadena = input('Ingrese la cadena a partir de la cual quiere crear una nueva lista')
frase = frase.lower()
cadena = cadena.lower()
frase = frase.split(' ')
cont = 0
for x in range(0,len(frase)):
    if cadena in frase[x]:
        cont = cont + 1
print(cont)
