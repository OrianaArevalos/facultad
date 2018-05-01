from pattern.es import conjugate,parse
from pattern.es import INFINITIVE,verbs
import collections
def verbosInfinitivos(cadena):
    lista = []
    palabras = parse(cadena).split()
    for x in palabras:
        for y in x:
             if ((y[1] == 'VB') or (y[1])=='VBI'):
                 lista.append(conjugate(y[0],INFINITIVE))
    return lista
def masUsados(frase):
    cnt = collections.Counter()
    for x in frase:
        cnt[x] += 1
    for letter, count in cnt.most_common(3):
         print (letter,count)
frase = input('Ingrese una frase')
lista = verbosInfinitivos(frase)
print(lista)
masUsados(lista)