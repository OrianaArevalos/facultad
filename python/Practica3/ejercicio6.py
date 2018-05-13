import csv,json
def CSV_a_JSON(nombre_csv):
    archi = open(nombre_csv, "r")
    csvreader = csv.reader(archi)
    ok = False
    lista = []
    diccionario = {}
    columna = []
    for fila in csvreader:
        if not ok :
            ok = True
            for x in range(20):
                columna.append(fila[x])
            print(columna)
        else:
            for x in range(20):
                print(columna[x] +'::='+ str(fila[x]))
                diccionario[columna[x]] = ( 0 if str(fila[x]) == '' else str(fila[x]) )
            lista.append(diccionario.copy()) 
    archivo = open("todasLasCarreras.json","w")
    json.dump(lista,archivo)
    archivo.close()
    archi.close()
CSV_a_JSON("Todas.las.carreras27032018.csv")