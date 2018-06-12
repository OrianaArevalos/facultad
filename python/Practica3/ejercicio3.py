import json
def modificoDatos():
    archivo = open("archivoJugadores.txt","r")
    jugadores = json.load(archivo)
    print("Ingrese los datos del jugador que quiere modificar o agregar")
    nombre = input("Ingrese el nombre del jugador")
    puntaje = int(input("Ingrese el puntaje del jugadore"))
    nivel = int(input("Ingrese el nivel del jugador"))
    tiempo = int(input("Ingrese el tiempo del jugador"))
    ok = False
    lista =[]
    for dic in jugadores:
        print(dic)
        lista.append(dic)
        if(dic['nombre'] == nombre):
             dic["puntaje"] = puntaje
             dic["tiempo"] = tiempo
             dic["nivel"] = nivel
             ok = True
             lista.pop()
             lista.append(dic)

    if ok:
        archivo = open("archivoJugadores.txt","w")
        json.dump(lista,archivo)
    else:
        archivo = open("archivoJugadores.txt","w")
        dic = {"nombre":nombre,"nivel":nivel,"puntaje":puntaje,"tiempo":tiempo}
        lista.append(dic)
        json.dump(lista,archivo)
modificoDatos()