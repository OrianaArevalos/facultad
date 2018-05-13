import os
def leer_archivos(): 
  lista = os.listdir("./imagenes/")
  imagenes = {}
  for elem in lista:
    if os.path.isdir(os.path.join("./imagenes",elem)):
      direccion = "./imagenes/"+elem
      imagenes[elem] = os.listdir(direccion)
  return imagenes
print(leer_archivos())