string = 'colores : rojo naranja amarillo verde azul indigo violeta blanco negro marron, figuras: cuadrado triangulo rectangulo circulo elipse rombo trapezoide, frutas: manzana naranja limon lima pera uva melon banana mango frutilla, animales: murcielago oso gato perro mono pato aguila pez leon rata panda'
print (string);
string = string.split(',');
palabra = {};
for x in string:
    x = x.split(':');
    valor = x[1].split( );
    clave = x[0];
    clave = clave.strip(' ');
    palabra[clave] = valor;
print (palabra); 