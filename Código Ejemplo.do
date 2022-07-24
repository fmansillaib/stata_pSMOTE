
* Santiago de Chile
* 07/2022
* -------------------- *
* Ejemplo Código SMOTE *
* -------------------- *
* Franco A. Mansilla Ib.

* Base de Datos *
sysuse auto, clear 

* Limpieza * 
drop make 

* SNAPSHOT
snapshot save, label("base_original")

* Tabulación Foreign (sin pSMOTE) *
tab foreign 

	* Nota 1: La variable foreign se encuentra bien codifica (0 y 1).
	* Nota 2: Siendo la clase 1 la minoritaria. En el caso contrario, habra que crear una nueva variable.
	
* Car origin |      Freq.     Percent        Cum.
*------------+-----------------------------------
*   Domestic |         52       70.27       70.27
*    Foreign |         22       29.73      100.00
*------------+-----------------------------------
*      Total |         74      100.00

	* OJO: La variable REP78 tiene 5 valores perdidos, estos valores perdidos se asignara un numero por el codigo.

	
* Lista de variables *
ds foreign, not
global var_x = r(varlist)

* ===========
* Ejemplo 1:
* ===========

* pSMOTE (con balance 85%)
psmote $var_x, var_y(foreign) class_min(22) sample(all_sample) balance(85) seed(42)

* RESULTADO (pSMOTE con 85% de balance)
* Car origin |      Freq.     Percent        Cum.
*------------+-----------------------------------
*   Domestic |         52       51.49       51.49
*    Foreign |         49       48.51      100.00
*------------+-----------------------------------
*      Total |        101      100.00


* ===========
* Ejemplo 2:
* ===========
snapshot restore 1

* Muestra Aleatoria 
set seed 43

gen muestra = runiform()
replace muestra = 1 if muestra <=0.75
replace muestra = 0 if muestra != 1


tab foreign if muestra == 1

* pSMOTE (con balance 85%)
psmote $var_x, var_y(foreign) class_min(17) sample(muestra) balance(85) seed(42)

* Resultado con Muestra y 85%
*Car origin |      Freq.     Percent        Cum.
*-----------+-----------------------------------
*  Domestic |         38       52.05       52.05
*   Foreign |         35       47.95      100.00
*-----------+-----------------------------------
*     Total |         73      100.00
 


* ===========
* Ejemplo 3:
* ===========
snapshot restore 1

* Muestra Aleatoria 
set seed 43

gen muestra = runiform()
replace muestra = 1 if muestra <=0.75
replace muestra = 0 if muestra != 1


tab foreign if muestra == 1

* pSMOTE (con balance 100%)
psmote $var_x, var_y(foreign) class_min(17) sample(muestra) balance(100) seed(43)

* Resultado con Muestra y 100%
* Car origin |      Freq.     Percent        Cum.
*------------+-----------------------------------
*   Domestic |         38       50.00       50.00
*    Foreign |         38       50.00      100.00
*------------+-----------------------------------
*      Total |         76      100.00

 





* creado, por: Franco A. Mansilla Ibañez
* Linkedin: https://www.linkedin.com/in/francomansilla/
* Medium: https://medium.com/@fmansillaib


