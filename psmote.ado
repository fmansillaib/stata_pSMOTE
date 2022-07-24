
* Código de balanceo de clases desequilibradas *
* creado por: Franco A. Mansilla Ibañez, Chile.
* Para mayor información leer: Guía de Instalación y Uso. 

program drop psmote

program define psmote, rclass
version 17

set more off 

args  var_y var_x  clas_min balance seed 
syntax varlist , var_y(string) sample(string) class_min(integer) balance(integer) seed(integer)

return local varname `varlist'

quietly ssc install moreobs
quietly ssc install unique

set seed `seed'

* ======================
* No todas las muestras
* ======================

if "`sample'" != "all_sample" {
* Numero de Observaciones de la Clase minoritaria
if `class_min' <= 300 {
	
	quietly global n_cluster = 3
 
	 quietly cluster kmeans `varlist' if `var_y'  & `sample'==1, k($n_cluster) measure(L2) start(krandom(`seed')) 
	
	 quietly count if `var_y'== 1 & `sample'==1
	 quietly global total_1 = r(N)
	 quietly count if `var_y'== 0 & `sample'==1
	 quietly global total_0 = r(N)


	quietly global add_obs = round((( $total_0 - $total_1 ) * (`balance')/100 ) /$n_cluster,1 ) 


	forvalues j = 1/$n_cluster {

	quietly moreobs $add_obs
	 
	quietly replace `var_y' = 1 if `var_y' == .
	quietly replace `sample' = 1 if `sample' == .
	
	foreach i in `varlist'{
		
		quietly unique `i' if `i' != . & `sample'==1
		
		global unique = r(unique)
		
		if $unique <= 30 {
		
		quietly sum `i' if _clus_1 == `j' & `sample'==1
		quietly replace `i' = round(runiform(r(min),r(max)), 1) if `i' == . & `sample'==1
		
		}
		
		if $unique > 30 {
			
		quietly sum `i' if _clus_1 == `j' & `sample'==1
		quietly replace `i' = runiform(r(min),r(max)) if `i' == . & `sample'==1
		
		}
		
	}
	}
	}


if (`class_min' > 300 & `class_min' <= 800)  {
	
	quietly global n_cluster = 5
 
	 quietly cluster kmeans `varlist' if `var_y' ==1 & `sample'==1 , k($n_cluster) measure(L2) start(krandom(`seed')) 
	
	 quietly count if `var_y'== 1 & `sample'==1
	 quietly global total_1 = r(N)
	 quietly count if `var_y'== 0 & `sample'==1
	 quietly global total_0 = r(N)

	quietly global add_obs = round((($total_0 - $total_1) * (`balance')/100 ) /$n_cluster,1)


	forvalues j = 1/$n_cluster {

	quietly moreobs $add_obs
	 
	quietly replace `var_y' = 1 if `var_y' == .
	quietly replace `sample' = 1 if `sample' == .
	 
	foreach i in `varlist'{
		
		quietly unique `i' if `i' != . & `sample'==1
		
		global unique = r(unique)
		
		if $unique <= 30 {
			
		quietly sum `i' if _clus_1 == `j' & `sample'==1
		quietly replace `i' = round(runiform(r(min),r(max)), 1) if `i' == . & `sample'==1
		
		}
		
		if $unique > 30 {
			
		quietly sum `i' if _clus_1 == `j' & `sample'==1
		quietly replace `i' = runiform(r(min),r(max)) if `i' == .  & `sample'==1
		
		}
		
	}
	}
	}

	
if  `class_min' > 800 {
	
	quietly global n_cluster = 7
	
	 quietly cluster kmeans `varlist' if `var_y' ==1 & `sample'==1 , k($n_cluster) measure(L2) start(krandom(`seed')) 
	
	 quietly count if `var_y'== 1 & `sample'==1
	 quietly global total_1 = r(N)
	 quietly count if `var_y'== 0 & `sample'==1
	 quietly global total_0 = r(N)

	quietly global add_obs = round((($total_0 - $total_1) * (`balance')/100 ) /$n_cluster,1)

	forvalues j = 1/$n_cluster {

	quietly moreobs $add_obs
	 
	quietly replace `var_y' = 1 if `var_y' == .
	quietly replace `sample' = 1 if `sample' == .
	 
	foreach i in `varlist'{
		
		quietly unique `i' if `i' != . & `sample'==1
		
		global unique = r(unique)
		
		if $unique <= 30 {
			
		quietly sum `i' if _clus_1 == `j' & `sample'==1
		quietly replace `i' = round(runiform(r(min),r(max)), 1) if `i' == . & `sample'==1
		
		}
		
		if $unique > 30 {
			
		quietly sum `i' if _clus_1 == `j' & `sample'==1
		quietly replace `i' = runiform(r(min),r(max)) if `i' == . & `sample'==1
		
		}
		
	}
	}
	}
quietly drop _clus_1
}


* ===================
* Todas las Muestras
* ===================

if "`sample'" == "all_sample"  {
	
* Numero de Observaciones de la Clase minoritaria
if `class_min' <= 300 {
	
	quietly global n_cluster = 3
 
	 quietly cluster kmeans `varlist' if `var_y' , k($n_cluster) measure(L2) start(krandom(`seed')) 
	
	 quietly count if `var_y'== 1 
	 quietly global total_1 = r(N)
	 quietly count if `var_y'== 0 
	 quietly global total_0 = r(N)


	quietly global add_obs = round((( $total_0 - $total_1 ) * (`balance')/100 ) /$n_cluster,1 ) 


	forvalues j = 1/$n_cluster {

	quietly moreobs $add_obs
	 
	quietly replace `var_y' = 1 if `var_y' == .
	 
	foreach i in `varlist'{
		
		quietly unique `i' if `i' != . 
		
		global unique = r(unique)
		
		if $unique <= 30 {
		
		quietly sum `i' if _clus_1 == `j'
		quietly replace `i' = round(runiform(r(min),r(max)), 1) if `i' == . 
		
		}
		
		if $unique > 30 {
			
		quietly sum `i' if _clus_1 == `j' 
		quietly replace `i' = runiform(r(min),r(max)) if `i' == . 
		
		}
		
	}
	}
	}

if (`class_min' > 300 & `class_min' <= 800)  {
	
	quietly global n_cluster = 5
 
	 quietly cluster kmeans `varlist' if `var_y' , k($n_cluster) measure(L2) start(krandom(`seed')) 
	
	 quietly count if `var_y'== 1 
	 quietly global total_1 = r(N)
	 quietly count if `var_y'== 0 
	 quietly global total_0 = r(N)

	quietly global add_obs = round((($total_0 - $total_1) * (`balance')/100 ) /$n_cluster,1)


	forvalues j = 1/$n_cluster {

	quietly moreobs $add_obs
	 
	quietly replace `var_y' = 1 if `var_y' == .
	 
	foreach i in `varlist'{
		
		quietly unique `i' if `i' != . 
		
		global unique = r(unique)
		
		if $unique <= 30 {
			
		quietly sum `i' if _clus_1 == `j' 
		quietly replace `i' = round(runiform(r(min),r(max)), 1) if `i' == . 
		
		}
		
		if $unique > 30 {
			
		quietly sum `i' if _clus_1 == `j' 
		quietly replace `i' = runiform(r(min),r(max)) if `i' == .  
		
		}
		
	}
	}
	}

	
if  `class_min' > 800 {
	
	quietly global n_cluster = 7
	
	 quietly cluster kmeans `varlist' if `var_y', k($n_cluster) measure(L2) start(krandom(`seed')) 
	
	 quietly count if `var_y'== 1 
	 quietly global total_1 = r(N)
	 quietly count if `var_y'== 0 
	 quietly global total_0 = r(N)

	quietly global add_obs = round((($total_0 - $total_1) * (`balance')/100 ) /$n_cluster,1)

	forvalues j = 1/$n_cluster {

	quietly moreobs $add_obs
	 
	quietly replace `var_y' = 1 if `var_y' == .
	 
	foreach i in `varlist'{
		
		quietly unique `i' if `i' != . 
		
		global unique = r(unique)
		
		if $unique <= 30 {
			
		quietly sum `i' if _clus_1 == `j' 
		quietly replace `i' = round(runiform(r(min),r(max)), 1) if `i' == . 
		
		}
		
		if $unique > 30 {
			
		quietly sum `i' if _clus_1 == `j' 
		quietly replace `i' = runiform(r(min),r(max)) if `i' == . 
		
		}
		
	}
	}
	}
quietly drop _clus_1
}
	


display " "
display "* ------------------------------------- *"
display "*  Resumen de la Información Utilizada *"
display "* ------------------------------------- *"
display " "
display "-> Variable Clase: `var_y'"  
display "-> Semilla Utilizada: " `seed'
display "-> Variable(s): `varlist'" 
display "-> Cantidad de Obs. en equilibrar: " ($total_0 - $total_1)
display "-> Sample: " "`sample'"
display " "
display "-> Resultado:"

if "`sample'" == "all_sample"{
	tab `var_y'
}
if "`sample'" != "all_sample"{
	tab `var_y' if `sample' == 1
} 

display " "
display " "
display "* creado, por: Franco A. Mansilla Ibañez"
display "* Linkedin: https://www.linkedin.com/in/francomansilla/"
display "* Medium: https://medium.com/@fmansillaib"



end 
 