import collections
frase= "Si trabajás mucho con computadoras, eventualmente encontrarás que te gustaría automatizar alguna tarea. Por ejemplo, podrías desear realizar una búsqueda y reemplazo en ungran número de archivos de texto, o renombrar y reorganizar un montón de archivos con fotos de una manera compleja. Tal vez quieras escribir alguna pequeña base de datos personalizada, o una aplicación especializada con interfaz gráfica, o un juego simple."
cnt = collections.Counter()
frase = frase.split()
for x in frase:
    cnt[x] += 1
for letter, count in cnt.most_common(3):
    print (letter,count)