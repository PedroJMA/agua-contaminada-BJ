* Censo de Población y Vivienda 2020
* 2024-04-22
* do "/Users/pedrojma/Documents/GitHub/agua-contaminada-BJ/2-Codigo/censo2020.do"


clear 
set more 1 
set type double 
cap log close 

global drs "/Users/pedrojma/Documents/GitHub/agua-contaminada-BJ/5-Resultados/"
global drdata "/Users/pedrojma/Documents/GitHub/agua-contaminada-BJ/1-Datos/"
global drcenso "/Volumes/TOSHIBA EXT/Data/Censo2020/"

******************************************************
local RunITER = 0 // Principales resultados por localidad (ITER)
local RunAGEB = 0 // Principales resultados por AGEB y manzana urbana
local RunEntornoUrbano = 1 // Resultados sobre características del entorno urbano
******************************************************

if `RunITER'==1 {
    import delimited "${drcenso}ITER/ITER_09CSV20.csv", clear varnames(1)

}
* RunITER
******************************************************

if `RunAGEB'==1 {
    
    import delimited "${drcenso}AGEB/RESAGEBURB_09CSV20.csv", clear varnames(1)
    save "${drdata}censo2020_ageb_ce09.dta", replace 
    d,s 

}
* RunAGEB
******************************************************

if `RunEntornoUrbano'==1 {
    * Manzana
    import delimited "${drcenso}entorno_urbano/Censo2020_CEU_cdmx_csv/TI_MANZANA_EU_09.csv", clear varnames(1)
    save "${drdata}censo2020_entorno_manzana_ce09.dta", replace 
    d,s 

    duplicates report id_mza ageb mza
    tab mun puesambu_c,m 

    * vialidad 
    import delimited "${drcenso}entorno_urbano/Censo2020_CEU_cdmx_csv/TR_VIALIDAD_EU_09.csv", clear varnames(1)
    save "${drdata}censo2020_entorno_vialidad_ce09.dta", replace 
    d,s 

    duplicates report id_fte id_mza ageb mza
    tab mun puestoambu,m 
}
* RunEntornoUrbano

******************************************************

/*  */