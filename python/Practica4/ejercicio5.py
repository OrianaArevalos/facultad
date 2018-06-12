def diccionarioPrueba(diccionario):
    try:
        raise(NameError('hola pepe'))
        try:
            for x in range(4):
                print(diccionario[x])
        except (NameError) as var:
            print(var.message)
        finally:
            print('pepe')
        print("hola como andas?")
    except KeyError as var:
        print(var)
    print("hola probando")
diccionario = {1:"hola",2:"tres",4:"cuatro"}
diccionarioPrueba(diccionario)
    
