imagenes=['im1','im2','im3']
img = {}
num = 0
for im in imagenes:
    print("Ingrese la coordenada")
    XY=(int(input("Ingrese la coordenada x1")),int(input("Ingrese la coordenada y2")))
    if (num != 0):
        if (num == 1):
            if (img['im1'] == XY):
                XY=(int(input("Ingrese la coordenada x1")),int(input("Ingrese la coordenada y2")))
        else:
            while (img['im1']==XY) or (img['im2'] == XY):
                XY=(int(input("Ingrese la coordenada x1")),int(input("Ingrese la coordenada y2")))
    img[im]=XY
    num = num+1
print(img)
#podria hacer un tupla con x,y
