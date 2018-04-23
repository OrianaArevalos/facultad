puntaje = {}
puntaje[30] = 'Ada'
puntaje[40] = 'Hedy Lammar'
puntaje[45] = 'Colossus'
puntaje[47] = 'Angela Ruiz Robles'
for punt in puntaje.keys():
    nombre = puntaje[punt]
    print (punt,nombre)
    print('{} puntaje {}'.format(nombre, puntaje))