import json, os
def leer_archivos(direccion): 
    lista = os.listdir(direccion)
    dic_directorio = {} 
    lista_final = []
    ok = False
    for elem in lista:
        if os.path.isfile(os.path.join(direccion+"/",elem)):
             lista_final.append(elem)
        else:
            if os.path.isdir(os.path.join(direccion+"/",elem)):
                ok = True
                dic_directorio[elem] = leer_archivos(direccion+"/"+elem)
    if ok:
        lista_final.append(dic_directorio.copy())
    return lista_final
def guardar_estructura(direccion):
    lista = leer_archivos(direccion)
    archivo = open("pepe.json","w")
    json.dump(lista,archivo)
    archivo.close()
guardar_estructura("./imagenes/")