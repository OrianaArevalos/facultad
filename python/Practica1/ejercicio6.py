frase= "Si trabajás mucho con computadoras, eventualmente encontrarás que te gustaría automatizar alguna tarea. Por ejemplo, podrías desear realizar una búsqueda y reemplazo en ungran número de archivos de texto, o renombrar y reorganizar un montón de archivos con fotos de una manera compleja. Tal vez quieras escribir alguna pequeña base de datos personalizada, o una aplicación especializada con interfaz gráfica, o un juego simple."
frase = frase.upper()
frase = frase.split()
print(frase)
porLetras = {}
for string in frase:
    if len(string) not in porLetras:
        porLetras[len(string)] = []
    porLetras[len(string)].append(string)
print(porLetras)
#recorro y pregunto si ya esta. con un if
