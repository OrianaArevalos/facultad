class Puntaje():

    def __init__(self, un_nivel, los_puntos, un_tiempo):
        self.__nivel = un_nivel 
        self.__puntos = los_puntos
        self.__tiempo = un_tiempo

    def getNivel(self):
        return self.__nivel
    
    def getPuntos(self):
        return self.__puntos

    def getTiempo(self):
        return self.__tiempo

    def setNivel(self,un_nivel):
        self.__nivel = un_nivel

    def setPuntos(self, los_puntos):
        self.__puntos = los_puntos
    
    def setTiempo (self, un_tiempo):
        self.__tiempo = un_tiempo

class Jugador():

    def __init__(sel, un_nombre, los_puntajes):
        self.__nombre = un_nombre
        self.__puntajes = los_puntajes

    def getNombre(self):
        return self.__nombre

    def getPuntajes(self):
        return self.__puntajes

    def setNombre(self, un_nombre):
        self.__nombre = un_nombre
    
    def setPuntajes(self, los_puntajes):
        self.__puntajes = los_puntajes
    
    def nivelMaximo(self):
        nivel_maximo = -1
        for pun in self.getPuntajes:
            if (pun.getNivel() > nivel_maximo):
                nivel_maximo = pun.getNivel()
        return nivel_maximo
    
    def cantidadTotalPuntajes(self):
        return len(self.getPuntajes())

    def puntajeMaximo(self, un_nivel):
        puntaje_maximo = -1
        for pun in self.getPuntajes():
            if (pun.getNivel() == un_nivel):
                if (pun.getPuntos() > puntaje_maximo):
                    puntaje_maximo = pun.getPuntos()
        return puntaje_maximo

    def menorTiempo(self, un_nivel):
        tiempo_minimo = -1
        for pun in self.getPuntajes():
            if (pun.getNivel() == un_nivel):
                if (pun.getTiempo() < tiempo_minimo):
                    tiempo_minimo = pun.getTiempo()
        return tiempo_minimo