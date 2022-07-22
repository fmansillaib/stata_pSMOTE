# [STATA: proxy de SMOTE (pSMOTE)](https://drive.google.com/drive/folders/15kW1maLs2cRrP2HynBgrp4AzSiW6N0Y-?usp=sharing) 

- #### Creado, por: Franco A. Mansilla Ibañez, Chile.
- email: franco.andres.mansilla@gmail.com
- Linkedin: https://www.linkedin.com/in/francomansilla/
- Medium: https://medium.com/@fmansillaib

## Download Carpeta: 
- Contenido: Guía de usuario; psmote.ado y Ejemplo_practico.do.

## Descripción del Código: [Pincha Aquí](https://drive.google.com/drive/folders/15kW1maLs2cRrP2HynBgrp4AzSiW6N0Y-?usp=sharing)

1. El código psmote.ado te permitirá  balancear clases de una variable dicotómica que se encuentra desbalanceada. 
2. El código utiliza una técnica de clusterización para definir el método para crear muestras sintéticas en función de esos clusters.
3. La cantidad de cluster que se utilizaran dependerá de la cantidad de observaciones que tendrás en tu clase desbalanceada. 

## Instalación:
- Paso 1: Descargar el archivo smote.ado 
- Paso 2: Ir a la carpeta de Stata (usualmente Disco C) -> Carpeta ado -> Guardar archivo en letra “S”.
- Paso 3: Cerrar y Abrir Stata. 
- Paso 4: Utilizar código.

## Syntax 

En stata llamar, código:

```stata
  psmote var_x (var's_x), var_y (variable) class_min (#) balance (#) seed (#)
```

- **var_x:** Señalar la(s) variable(s) en que el código analizara. 
- **var_y:** Señalar una única variable (grupo).
-	**class_min:** Señalar la cantidad de observaciones que tiene clase minoritaria. 
-	**balance:** Señalar el porcentaje a completar la clase desequilibra con respecto a la clase completa (señalar entre 0 a 100 que equivale a 0% a 100%).
-	**seed:** Señalar la semilla de iniciación del código. 


## Alcance:

1. La variable clase tiene que estar codificada como 0 o 1, donde la clase 1 es el minoritario. En otra caso, deberá crear una variable con la nomenclatura señalada recién.
2. La variables **var_x** y **var_y** deben estar ausentes de valores missing. Al dejar valores missing, la técnica rellenara esos valores missing. 
3. Solo funciona para variable clase (**var_y**) dicotómica, no así categórica o continua; a no ser que haga la transformación respectiva a dicotómica. 

## Resultado Ejemplo:
- Sin aplicar el código pSMOTE:
![sin pSMOTE](https://github.com/fmansillaib/stata_pSMOTE/blob/main/4.%20Imagenes/1.sin_psmote.png)

- Con aplicar el código pSMOTE (balance 100):
![con pSMOTE](https://github.com/fmansillaib/stata_pSMOTE/blob/main/4.%20Imagenes/2.con_psmote.png)

