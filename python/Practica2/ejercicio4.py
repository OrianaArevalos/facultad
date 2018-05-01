from pattern.es import singularize, pluralize
def convertir(dic):
    diccionario = {}
    for clave in dic:
        lista = dic[clave]
        listaAux = []
        if (clave == 's'):
            for elem in lista:
                listaAux.append(pluralize(elem))
            diccionario['p'] = listaAux
        else:
            for elem in lista:
                listaAux.append(singularize(elem))
            diccionario['s'] = listaAux
    return diccionario
dic={'s':['gato','perro','tortuga'],'p':['perros','gatos','jirafas']}
print(convertir(dic))