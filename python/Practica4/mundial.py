import random
from functools import reduce 

class Equipo:
  '''completar la definición de la clase Equipo, métodos: constructor y dame_mejor_jugador'''
  def __init__(self, un_nombre, los_jugadores):
      self.nombre = un_nombre
      self.jugadores = los_jugadores
      
  def dame_mejor_jugador(self):
      mayor = reduce(lambda a,b:a if (a.puntos() > b.puntos()) else b, self.jugadores)
      return(mayor)

  

class Jugador:
  '''completar la definición de la clase Jugador, métodos: constructor, inc_gol, inc_pase, inc_defensa y puntos'''
  def __init__(self, un_nombre, una_posicion):
      self.nombre = un_nombre
      self.posicion = una_posicion
      self.gol = 0
      self.pase = 0
      self.defensa = 0
  pass
  def inc_gol(self):
      self.gol += 1

  def inc_pase(self):
      self.pase += 1
    
  def inc_defensa(self):
      self.defensa += 1
    
  def puntos(self):
      if (self.posicion == "defensor"):
          return self.defensa * 3 + self.pase * 2 + self.gol
      elif (self.posicion == "mediocampista"):
          return self.pase * 3 + self.gol * 2 + self.defensa
      else:
          return self.gol * 3 + self.pase * 2 + self.defensa
  pass

# No modificar la generación de equipos. Se deben respetar los nombres de clases, métodos y sus parámetros.
def generar_equipos():
  lista_equipos = []    
  for equipo_i in range(64):
    lista_jugadores = []
    for jugador_i in range(10):
      # Creación de un objeto de clase Jugador con: nombre "Jugador XX" y su posición
      jugador = Jugador('Jugador ' + str(jugador_i), random.choice(['defensor','mediocampista','delantero']))
      for goles in range(random.randint(0,10)):
        jugador.inc_gol()
      for pases in range(random.randint(0,10)):
        jugador.inc_pase()
      for defensas in range(random.randint(0,10)):
        jugador.inc_defensa()
      lista_jugadores.append(jugador)
    # Creación de un objeto de clase Equipo con: nombre "Equipo XX" y lista de jugadores
    lista_equipos.append(Equipo('Equipo '+str(equipo_i), lista_jugadores))
  return lista_equipos


def imprimir_mejor_jugador(lista_equipos):
    # Implementar
    mayor = reduce(lambda a,b:a if (a.dame_mejor_jugador().puntos() > b.dame_mejor_jugador().puntos()) else b, lista_equipos)
    print(mayor.dame_mejor_jugador().nombre)


equipos = generar_equipos()
imprimir_mejor_jugador(equipos) 
jugador1 = Jugador('Oriana','defensor')
jugador1.inc_defensa()
jugador1.inc_gol()
jugador1.inc_gol()
jugador1.inc_pase()
jugador2 = Jugador('pore','delantero')
jugador2.inc_defensa()
jugador2.inc_gol()
jugador2.inc_gol()
jugador2.inc_pase()
jugador3 = Jugador('pepito','mediocampista') 
jugador3.inc_defensa()
jugador3.inc_gol()
jugador3.inc_gol()
jugador3.inc_pase()

jugador12 = Jugador('jdfshfad','defensor')
jugador12.inc_defensa()
jugador12.inc_gol() 
jugador12.inc_pase()
jugador22 = Jugador('jdshjafd','delantero')
jugador22.inc_defensa()
jugador22.inc_gol() 
jugador22.inc_pase()
jugador32 = Jugador('fdsahfad','mediocampista') 
jugador32.inc_defensa()
jugador32.inc_gol() 
jugador32.inc_pase()
print(jugador1.puntos(),jugador2.puntos(),jugador3.puntos())
equipo1 = Equipo('argentina',[jugador1,jugador2,jugador3])
equipo2 = Equipo('polonia',[jugador12,jugador22,jugador32])
print(equipo2.dame_mejor_jugador().nombre)
print(equipo1.dame_mejor_jugador().nombre)
equipitos = [equipo1,equipo2]
imprimir_mejor_jugador(equipitos)