import os,stat,time
lista_archivos = []
lista = os.listdir()
for elem in lista:
    if os.path.isfile(elem):
        print(elem)
        print(os.stat(elem).st_size)
        print(time.ctime(os.stat(elem).st_mtime))
mayuscula = [lambda lista.Capitalize]
print(mayuscula) 