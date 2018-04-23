frase = "Si trabajás mucho CON computadoras, eventualmente encontrarás que te gustaría automatizar alguna tarea. Por ejemplo, podrías desear realizar una búsqueda y reemplazo en un gran número DE archivos de texto, o renombrar y reorganizar un montón de archivos con fotos de una manera compleja. Tal vez quieras escribir alguna pequeña base de datos personalizada, o una aplicación especializada con interfaz gráfica, o UN juego simple."
frase = frase.lower()
frase = frase.split()
conjunto=set(frase)
print(conjunto)
lista=[]
for string in frase:
    if lista.count(string) == 0 :
        lista.append(string)
print (lista)

#puedo usar conjuntos
