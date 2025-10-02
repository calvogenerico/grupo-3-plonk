---
layout: image-right
image: /img/rompecabezas.png
transition: none
---

# Vamos por partes

<v-click>

### ¿Que es plonk?

</v-click>

<v-clicks>

- Mas allá de la definición formal, es un método muy piola
    para demostrar cómputo.

- Hay una parte de plonk que es modular (el método para caomprometerse a un polinomio). Pero acá vamos a asumir kzg (la cosa de pairings que nos explicó el chino)

</v-clicks>

---
layout: image-right
image: /img/rompecabezas.png
transition: slide-left
---

# Vamos por partes

### Funcionamiento a lo bruto




<v-clicks>

- Primero que nada me llueve un trusted setup del cielo.
- Genero la traza (o witness si quiero sonar cool).
- Guardo la traza adentro de un polinomio.
- Demuestro que ese polinomio existe sin compartirlo.

- Esos 4 pasos son magia pura. Hoy vamos a tratar de que esa magia tenga un chorro de realidad y máxima ciencia (no se preocupen, algo de magia siempre queda).

</v-clicks>

---
layout: default
transition: none
---

# Hablemos del trusted setup

<v-clicks>

- Tenemos una curva Elíptica $E$
- Tenemos un generador $G$
- Tenemos un polinomio sobre nuestra curva elíptica de la forma $P(x) = 3x^3 + 2x^2 - 5$
- En algún momento nuestra prueba va a requerir que alguien evalúe un polinomio parecido a $P$ (pero mas grande) en un múltiplo de $G$ sin saber que múltiplo es.
- Vamos a llamar a ese factor deconocido y mágico $\tau$

</v-clicks>

---
layout: default
transition: none
---

# Hablemos del trusted setup

> curva $E$ || generador $G$ || polinomio $P(x) = 3x^3 + 2x^2 - 5$ || misterio $\tau$

### Trucardo:

Le damos a la otra persona:

- $\tau^0 G = G$
- $\tau^1 G = \Omega_1$
- $\tau^2 G = \Omega_2$
- $\tau^3 G = \Omega_3$


---
layout: default
transition: slide-left
---

# Hablemos del trusted setup

> curva $E$ || generador $G$ || polinomio $P(x) = 3x^3 + 2x^2 - 5$ || misterio $\tau$
>
> Conocemos $G,\Omega_1,\Omega_2,\Omega_3$

<v-clicks>

- Ahora evaluemos nuestro poliminio en $\tau$
- $P(x) = 3x^3 + 2x^2 - 5$
- $P(\tau) = 3(\tau^3G) + 2(\tau^2 G) - 5G$ _(acuerdense que estamos siempre en un grupo generado por $G$, $G$ está por todos lados)_
- Vaya casualidad que sabemos que $(\tau^3G)=\Omega_3$ y $(\tau^2G)=\Omega_2$
- Los valores de los $\Omega_i$ los sabemos. Tipo, tenemos el numerito, porque nos lo dieron.
- Ahora entonces podemos calcular el valor de polinimio evaluado en $\tau$ sin saber quién es $\tau$.
- $P(\tau) = 3\Omega_3 + 2\Omega_2 - 5G$  <-- Todos esos valores los sabemos


</v-clicks>


---
layout: two-cols-header
transition: slide-left
---

# Mejor que no saberlo yo es que no lo sepa nadie.

En realidad no quería que el otro no lo sepa. Para eso vamos a tener muchos
factores tau secretos.

::left::

<v-click>

## Persona 1

- $\tau_1^0 G = G$
- $\tau_1^1 G = \Omega_1$
- $\tau_1^2 G = \Omega_2$
- $\tau_2^3 G = \Omega_3$


</v-click>

<v-click>

## Persona 2

- $\tau_2^0 G = G$
- $\tau_2^1 \Omega_1 = \Alpha_1 = \tau_1^1 \tau_2^1 G$
- $\tau_2^2 \Omega_2 = \Alpha_2 = \tau_1^2 \tau_2^2 G$
- $\tau_2^3 \Omega_3 = \Alpha_3 = \tau_1^3 \tau_2^3 G$


</v-click>

::right::

<v-click>

## Persona 3

- $\tau_3^0 G = G$
- $\tau_3^1 \Alpha_1 = \Beta_1 = \tau_1^1 \tau_2^1 \tau_3^1 G$
- $\tau_3^2 \Alpha_2 = \Beta_2 = \tau_1^2 \tau_2^2 \tau_3^2 G$
- $\tau_3^3 \Alpha_3 = \Beta_3 = \tau_1^3 \tau_2^3 \tau_3^3 G$

</v-click>

<v-click>

## Persona n

- $\tau_n^0 G = G$
- $\tau_n^1 \Beta_1 = \Gamma_1 = \tau_1^1 ... \tau_n^1 G$
- $\tau_n^2 \Beta_2 = \Gamma_2 = \tau_1^2 ... \tau_n^2 G$
- $\tau_n^3 \Beta_3 = \Gamma_3 = \tau_1^3 ... \tau_n^3 G$

</v-click>


---
layout: default
transition: none
---

# Guardar datos en un polinomio

- N puntos definen un polinimio de grado N.

<v-clicks>

- Tengo el mensaje "hola", es decir "h", "o", "l", "a".
- O en ascii... 104, 111, 108, 97.
- Me podría definir 4 puntos que sean, por ejemplo... (1, 104), (2, 111), (3, 108), (4, 97).

</v-clicks>

---
layout: default
transition: slide-left
---

# Guardar datos en un polinomio

- N puntos definen un polinimio de grado N.

> (1, 104), (2, 111), (3, 108), (4, 97)

<v-clicks>

- Para conseguir el polinomio que pasa por los puntos podemos interpolar a mano, o hacer lagrange, o hacer py-lagrange:

```python
import numpy as np

from scipy.interpolate import lagrange

x = np.array([1, 2, 3, 4])

y = np.array([104, 111, 108, 97])

poly = lagrange(x, y)

# 1/3 x^3 - 7x^2 + 25.67 x + 85
```

- El polinomio resultado tiene adentro mi mensaje (casi hacker)


</v-clicks>

---
layout: image-right
image: /img/geometrico.jpg
transition: slide-left
---

# Aritmetización

_En realidad a mi me gusta hablar de compiladores y esto es lo mas parecido que encontré_


---
layout: two-cols
transition: none
---

# Programa

```typescript
const input = [1,2,3];
const sum = 0;
for (let i = 0; i<input.length; i++) {
    sum += input[i];
}

const prod = input[0] * prod[1];

const square = sum ** 2;

const res = square + prod

console.log(res);
```

<v-click>

- loops
- estado
- tipos de datos
- mar de posibilidades

</v-click>

::right::

# Circuito


```mermaid {scale: 0.5, alt: 'A simple sequence diagram'}
graph TD
    I1["input[0]"] --> B{+};
    I2["input[1]"] --> B;
    B --> C{+};
    I3["input[2]"] --> C;

    I2 --> D{*};
    I3 --> D;

    C --> E{*};
    C --> E;

    E --> F{+};
    D --> F;
    F --> Out;
```

<v-click>

- tamaño fijo
- todo es inmutable postap posta
- todo es un _field_
- no hay ramificación de ejecución

</v-click>

---
layout: two-cols
transition: slide-left
---

La aritmtización de plonk a grandes razgos es una estrategia para armar circuitos de este estilo.

Los circuitos tienen largo fijo y la ejecución no se puede ramificar. Además
se tienen que limitar a un set de operaciones muy específico.

En este circuito cada cuadradito es un "input".
Cada rombito es un "gate".

Las "gates" son operaciones que toman 2 inputs y un output.

::right::

# Circuito


```mermaid {scale: 0.5, alt: 'A simple sequence diagram'}
graph TD
    I1["input[0]"] --> B{+};
    I2["input[1]"] --> B;
    B --> C{+};
    I3["input[2]"] --> C;

    I2 --> D{*};
    I3 --> D;

    C --> E{*};
    C --> E;

    E --> F{+};
    D --> F;
    F --> Out;
```

- tamaño fijo
- todo es inmutable postap posta
- todo es un _field_
- no hay ramificación de ejecución


---
layout: default
transition: slide-left
---

# Plonk gates