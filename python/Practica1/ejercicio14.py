tam={'im1':[(1,13),(13,1)],'im2':[(1,13),(13,13)],'im3':[(1,40),(13,30)]}
imagenes=['im1','im2','im3']
img = {}
num = 0
for im in imagenes:
    print("Ingrese 3 coordenadas")
    x1 = int(input("Ingrese la coordenada x1"))
    y1 = int(input("Ingrese la coordenada y2"))
    if (num != 0):
        if (num == 1):
            if img['im1'][0] == x1 and img['im1'][1] == y1:
                x1 = int(input("Ingrese la coordenada x1"))
                y1 = int(input("Ingrese la coordenada y2"))
        else:
            while ((img['im1'][0] == x1) and (img['im1'][1] == y1)) or  ((img['im2'][0] == x1) and (img['im2'][1] == y1)):
                x1 = int(input("Ingrese la coordenada x1"))
                y1 = int(input("Ingrese la coordenada y2"))
    img[im]=[x1,y1]
    num = num+1
print(img)
for im in img:
    print(im)
    if (img[im][0] > tam[im][0][0]) and (img[im][0] < tam[im][1][0]) and (img[im][1] < tam[im][0][1]) and (img[im][1] > tam[1][1]):
        print("La imagen "+im+" está dentro del rango.")
    else:
        print("La imagen "+im+" está fuera del rango.")
