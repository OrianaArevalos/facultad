from pattern.es import conjugate,parse
from pattern.es import INFINITIVE,verbs
def verbosInfinitivos(cadena):
    lista = []
    palabras = parse(cadena).split()
    for x in palabras:
        for y in x:
             if ((y[1] == 'VB') or (y[1])=='VBI'):
                 lista.append(conjugate(y[0],INFINITIVE))
    return lista
string = 'todas las personas comen y corren, las flores son lindas'
print(verbosInfinitivos(string))