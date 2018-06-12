import logging

logging.basicConfig(level=logging.DEBUG)
logging.debug('Este mensaje me dice los errores')

def dividir():
    try:
        numerador = int(input("Ingrese el numerador (numérico):"))
        denominador = int(input("Ingrese el denominador (numérico):"))
        print("El resultado es: {:0.2f}".format(numerador/denominador))
    except (ValueError) as e:
        print("Se produjo una excepcion por no ingresar un numero")
        #logging.exception(e)      
    except (ZeroDivisionError) as e:
        print("Se produjo una excepcion por querer dividir por 0")  

def abrir_archivo(archivo):
    try:
        open(archivo, "r")
    except (FileNotFoundError) as e:
        print("El archivo no existe.")
        #logging.exception(e)
        
dividir()
abrir_archivo("archivo_que_no_existe")