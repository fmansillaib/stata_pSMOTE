
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


* pSMOTE (con balance 100%)
psmote $var_x, var_y(foreign) class_min(22) balance(85) seed(42)

* RESULTADO (pSMOTE con 85% de balance)
* Car origin |      Freq.     Percent        Cum.
*------------+-----------------------------------
*   Domestic |         52       51.49       51.49
*    Foreign |         49       48.51      100.00
*------------+-----------------------------------
*      Total |        101      100.00




* creado, por: Franco A. Mansilla Ibañez
* Linkedin: https://www.linkedin.com/in/francomansilla/
* Medium: https://medium.com/@fmansillaib


