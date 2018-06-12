def leerArchivo(nombre):
    try:
        archivo = open(nombre,'r')
        numeros = archivo.readlines()
        numeros = ''.join(numeros)
        numeros = numeros.split('\n')
        for x in numeros:
            int(x)
        f.close
        print(numeros)
    except (FileNotFoundError):
        print("El archivo no exite.") 
    except (ErrorValue):
        print("Los valores del archivo no son numeros")

