import json
from pattern.es import conjugate,parse
from pattern.es import INFINITIVE,verbs
def leer_texto():
    archivo = open("archivoTexto.txt","r")
    string = archivo.read()
    lista = parse(string).split() 
    return lista
def generar_texto(lista):
    archivo = open("verbos.json","w")
    diccionario = {}
    for x in lista:
        for y in x: 
            if ((y[1] == 'VB') or (y[1])=='VBI'): 
                 verbo = conjugate(y[0],INFINITIVE)
                 if not verbo in diccionario:
                     diccionario[verbo] = 0
                 diccionario[verbo] = diccionario[verbo] + 1
    lista_verbos = []
    for clave in diccionario:
        lista_verbos.append({clave:diccionario[clave]})
    json.dump(lista_verbos,archivo)
lita_verbos = leer_texto()
generar_texto(lita_verbos)