import math
class Punto():

    def __init__(self,un_punto_x,un_punto_y):
        self.__x = un_punto_x
        self.__y = un_punto_y

    def getX (self):
        return self.__x
    
    def getY (self):
        return self.__y
    
    def setX (self,un_punto_x):
        self.__x = un_punto_x
    
    def setY (self,un_punto_y):
        self.__y = un_punto_y
    
    def calcularDistancia(self, un_punto):
        distancia_x = pow(self.getX() - un_punto.getX(),2)
        distancia_y = pow(self.getY() - un_punto.getY(),2)
        return math.sqrt(distancia_x + distancia_y)

    def esIgual(self, un_punto):
        if ((self.getX() == un_punto.getX()) and (self.getY() == un_punto.getY())):
            return True
        else:
            return False
    
    def sumarX(self, incremento_x):
        self.setX(self.getX()+incremento_x)
        return(self.getX(),self.getY())

    def sumarY(self,incremento_y):
        self.setY(self.getY()+incremento_y)
        return(self.getX(),self.getY())

punto_a = Punto(12,34)
punto_b = Punto(45,35)
print(punto_a.getX(),punto_a.getY())
print(punto_b.getX(), punto_b.getY())
print(punto_a.esIgual(punto_b))
punto_a.sumarX(8)
punto_a.sumarY(6)
print(punto_a.calcularDistancia(punto_b))