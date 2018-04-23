import random
palabras = [('grave',['molesto']),('aguda',['ratón']),('esdrujula',['murciélago'])]
def suma():
    numero1 = int(input('Ingrese un numero para la suma'))
    numero2 = int(input('Ingrese el otro numero para la suma'))
    resultado = numero1 + numero2
    posible_res = int(input('Ingrese el resultado'))
    if (posible_res == resultado):
        print('Acerto el resultado')
    else:
        print('El resultado que ingresó está mal, el resultado es ',resultado)

def palabra():
    indice = random.choice(palabras)
    tipo_palabra=input('La palabra que se muestra en pantalla de que tipo es?' + indice[1][0])
    if (tipo_palabra == indice[0]):
        print ('Acerto el tipo de palabra')
    else :
        print ('No acerto el tipo de palabra, el tipo de la palabra es '+ indice[0])

diccionario1 = {(2,3):'azul',(5,6):'amarillo'}
lista = list(diccionario1.keys())
indice = random.randrange(2)
if (diccionario1[lista[indice]] == 'azul'):
    suma()
else:
    palabra()
