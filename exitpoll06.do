version 9
drop _all
#delimit ;
set more off ;
capture log close ;
log using H:\Parametria\Data\exitpoll06.log, replace ;
set more off ;

*     ***************************************************************** *;
*       File-Name:      exitpoll06.do                                   *;
*       Date:           Feb 05, 2007                                    *;
*       Author:         MM                                              *;
*       Purnege:        Generates data file to perform analysis of 2006 *;
*                       election                                        *;
*       Input File:     p120_0606_base_exit_poll_nacional_a1_final.dta  *;
*                       p120_0606_base_exit_poll_nacional_a2_final.dta  *;
*                       p120_0606_base_exit_poll_nacional_b1_final.dta  *;
*                       p120_0606_base_exit_poll_nacional_b2_final.dta  *;
*       Output Files:   exitpoll06.log                                  *;
*       Data Output:    exitpoll06.dta                                  *;
*       Previous file:  none                                            *;
*       Status:         WHONOZ?                                         *;
*       Machine:        laptop                                          *;
*     ****************************************************************  *;

set mem 256m ;
cd "H:\Parametria\Data";

use "p120_0606_base_exit_poll_nacional_a1_final.dta", clear ;

*********************************;
* RENAME VARIABLES & MERGE SETS *;
*********************************;

drop  p0* clave edadrec1 edadrec2 ;

/* Questionnaire A2 */

append using "p120_0606_base_exit_poll_nacional_a2_final.dta" ;

ren p05a ad_scholar ; 
ren p05b ad_schools ;
ren p05c ad_insure ;
ren p05d ad_housing ;
ren p05e ad_oport ;
ren p09a scholar ; 
ren p09b schools ;
ren p09c insure ;
ren p09d housing ;
ren p09e oport ;

recode ad_scholar ad_schools ad_insure ad_housing ad_oport (. = 0) if p04==2 ;

drop  p0* clave edadrec ;

/* Questionnaire B1 */

append using "p120_0606_base_exit_poll_nacional_b1_final.dta" ;

ren p03 neg_ad ;
ren p04 pos_ad ;

drop  p0* clave edadrec ;


/* Questionnaire B2 */

append using "p120_0606_base_exit_poll_nacional_b2_final.dta" ;

ren ccc region ;
ren t_secc urbanicity ;
ren b female ;
ren c age ;
ren d decide ;
ren e pres_app ;
ren f splitter ;
ren g education ;
ren h income ;
ren i class ;
ren p01a Resp_lib ;
ren p01b PAN_lib ;
ren p01c PRI_lib ;
ren p01d PRD_lib ;
ren p02 econ_retro ;
ren p03 econ_prosp ;
ren p06 PID ;
ren p07 expect ;
ren p07a strategic ;
ren p08 pol_int ;
ren p09 mex_dem ;
ren p10a FCH_lib ;
ren p10b RMP_lib ;
ren p10c AMLO_lib ;
ren p11 balance ;
ren p12 change ;
ren l vote_pres ;
ren m vote_dep ;
ren p vote_df ;

drop  a a_1 j k clave edadrec idenreco dtto ;
summ ; 


*********************************;
* RECODE VARIABLES              *;
*********************************;

recode pres_app econ_retro econ_prosp (1 = 3) (2 = 1) (3 = 0) (4 = -1) (5 = -3) (98/99 = .) ;
recode PAN_lib PRI_lib PRD_lib FCH_lib RMP_lib AMLO_lib strategic decide (98/99 = .);
recode scholar schools insure housing oport (2 = 0)(98/99 = .) ;
recode ad_scholar ad_schools ad_insure ad_housing ad_oport (2 = 0)(98/99 = .) ;
recode pos_ad neg_ad PID education income class (98/99 = .) ;
recode expect (6 98/99 = .) ;
recode split strategic balance (1=0) (2=1) (98/99 = .) ;
recode mex_dem change (2=0) (98/99 = .) ;
recode pol_int (1=4) (2=3) (3=2) (1=4) (98/99 = .) ;
recode female (2 = 1) (1 = 0) (98/99 = .);

/* Recode questionnaire */

gen cuest = 1 if proyecto =="A1" ;
replace cuest = 2 if proyecto=="A2" ;
replace cuest = 3 if proyecto=="B1" ;
replace cuest = 4 if proyecto=="B2" ;

/* Computes ideological distances */

gen PAN_dist = (Resp_lib - PAN_lib)^2 if PAN_lib!=. & Resp_lib!=.  ;
gen PRI_dist = (Resp_lib - PRI_lib)^2 if PAN_lib!=. & Resp_lib!=.  ;
gen PRD_dist = (Resp_lib - PRD_lib)^2 if PAN_lib!=. & Resp_lib!=.  ;
gen FCH_dist = (Resp_lib - FCH_lib)^2 if FCH_lib!=. & Resp_lib!=.  ;
gen RMP_dist = (Resp_lib - RMP_lib)^2 if RMP_lib!=. & Resp_lib!=.  ;
gen AMLO_dist = (Resp_lib - AMLO_lib)^2 if AMLO_lib!=. & Resp_lib!=.  ;

tab1 PAN_dist PRI_dist PRD_dist FCH_dist AMLO_dist RMP_dist ;

/* Computes average placement for parties and candidates*/

local libs "PAN PRI PRD FCH RMP AMLO" ;

foreach y of local libs { ;
    gen `y'_lib_bar=. ;
    summ `y'_lib, meanonly ;
      replace `y'_lib_bar = r(mean) if proyecto=="B2" ;
};

summ PAN_lib_bar PRI_lib_bar PRD_lib_bar FCH_lib_bar RMP_lib_bar AMLO_lib_bar ;

/* Uncertainty measures */

gen U_PAN = (PAN_lib-PAN_lib_bar)^2 if proyecto=="B2";
gen U_PRI = (PRI_lib-PRI_lib_bar)^2 if proyecto=="B2";
gen U_PRD = (PRD_lib-PRD_lib_bar)^2 if proyecto=="B2";
gen U_FCH = (FCH_lib-FCH_lib_bar)^2 if proyecto=="B2";
gen U_RMP = (RMP_lib-RMP_lib_bar)^2 if proyecto=="B2";
gen U_AMLO = (AMLO_lib-AMLO_lib_bar)^2 if proyecto=="B2";

local uncert "U_PAN U_PRI U_PRD U_FCH U_RMP U_AMLO" ;
foreach p of local uncert { ;
    summ `p' ;
    replace `p' = r(max) if `p'==. & proyecto=="B2";
} ;

tab1 U_PAN U_PRI U_PRD U_FCH U_RMP U_AMLO ;

/* Split Ticket vote */
gen vote_split=1 if vote_pres!=. & vote_dep!=. & vote_pres!=vote_dep ;
replace vote_split=0 if vote_pres==vote_dep & vote_pres!=. & vote_dep!=.;


/* Policy extreme measures */

gen Lib_extreme = abs(5 - Resp_lib) ;
tab1 Lib_extreme ;


/* Policy balance measures */
/* Generates measures of distance betwen the midpoints of the two most */
/* preferred parties and the voter's mos preferred position            */

gen Pol_bal=. ;
gen unique_id = _n ;
foreach x of varlist unique_id { ;

    if PAN_dist<PRD_dist & PRD_dist<PRI_dist { ;
        replace Pol_bal = abs(Resp_lib - ((PAN_dist+PRD_dist)/2)) ;
        } ;

    else if PAN_dist<PRI_dist & PRI_dist<PRD_dist { ;
        replace Pol_bal = abs(Resp_lib - ((PAN_dist+PRI_dist)/2)) ;
        } ;

    else if PRI_dist<PAN_dist & PAN_dist<PRD_dist  { ;
        replace Pol_bal = abs(Resp_lib - ((PRI_dist+PAN_dist)/2)) ;
        } ;

    else if PRI_dist<PRD_dist & PRD_dist<PAN_dist   { ;
        replace Pol_bal = abs(Resp_lib - ((PRI_dist+PRD_dist)/2))  ;
        };
        
    else if PRD_dist<PAN_dist & PAN_dist<PRI_dist  { ;
        replace Pol_bal = abs(Resp_lib - ((PRD_dist+PAN_dist)/2)) ;
        } ;

    else if PRD_dist<PRI_dist & PRI_dist<PAN_dist  { ;
        replace Pol_bal = abs(Resp_lib - ((PRD_dist+PRI_dist)/2)) ;
        } ;

    else if PAN_dist>PRD_dist & PRD_dist==PRI_dist  { ;
        replace Pol_bal = abs(Resp_lib - ((PAN_dist+PRD_dist)/2)) ;
        } ;

    else if PAN_dist<PRD_dist & PRD_dist==PRI_dist  { ;
        replace Pol_bal = abs(Resp_lib - ((PAN_dist+PRD_dist)/2)) ;
        } ;

    else if PRI_dist>PAN_dist & PAN_dist==PRD_dist { ;
        replace Pol_bal = abs(Resp_lib - ((PRI_dist+PAN_dist)/2)) ;
        } ;

    else if PRI_dist<PAN_dist & PAN_dist==PRD_dist { ;
        replace Pol_bal = abs(Resp_lib - ((PRI_dist+PAN_dist)/2)) ;
        } ;

    else if PRD_dist>PAN_dist & PAN_dist==PRI_dist { ;
        replace Pol_bal = abs(Resp_lib - ((PRD_dist+PAN_dist)/2)) ;
        } ;

    else if PRD_dist<PAN_dist & PAN_dist==PRI_dist { ;
        replace Pol_bal = abs(Resp_lib - ((PRD_dist+PAN_dist)/2)) ;
        } ;

    else if PRI_dist==PAN_dist & PAN_dist==PRD_dist { ;
        replace Pol_bal = abs(Resp_lib - PAN_dist)  ;
        } ;
   } ;

tab1 Pol_bal ;

/* Generate distance between most preferred parties */

gen Dist=. ;

foreach x of varlist unique_id {;
        replace Dist = abs(PAN_dist-PRD_dist) if PAN_dist>PRD_dist & PRD_dist>=PRI_dist & proyecto=="B2" ;
        replace Dist = abs(PAN_dist-PRI_dist) if PAN_dist>PRI_dist & PRI_dist>=PRD_dist & proyecto=="B2" ;
        replace Dist = abs(PRI_dist-PAN_dist) if PRI_dist>PAN_dist & PAN_dist>=PRD_dist & proyecto=="B2" ;
        replace Dist = abs(PRI_dist-PRD_dist) if PRI_dist>PRD_dist & PRD_dist>=PAN_dist & proyecto=="B2" ;
        replace Dist = abs(PRD_dist-PAN_dist) if PRD_dist>PAN_dist & PAN_dist>=PRI_dist & proyecto=="B2" ;
        replace Dist = abs(PRD_dist-PRI_dist) if PRD_dist>PRI_dist & PRI_dist>=PAN_dist & proyecto=="B2" ;
        replace Dist = 0 if PRI_dist==PAN_dist & PAN_dist==PRD_dist & proyecto=="B2" ;
};

tab Dist ;

/* Generate dummy for in-between parties */
/* Signals whether a voter is located between his/her two most preferred parties */

gen bet_part=. ;
gen bet_part_bar=. ;

foreach x of varlist unique_id {;

    replace bet_part = 1 if (PAN_lib>Resp_lib & PRI_lib<Resp_lib & PRD_lib<Resp_lib) ;
    replace bet_part = 1 if (PRI_lib > Resp_lib & PAN_lib<Resp_lib & PRD_lib<Resp_lib) ;
    replace bet_part = 1 if (PRD_lib > Resp_lib & PAN_lib<Resp_lib & PRI_lib<Resp_lib) ;
    replace bet_part = 1 if (PAN_lib > Resp_lib & PRI_lib>Resp_lib & PRD_lib<Resp_lib) ;
    replace bet_part = 1 if (PRI_lib > Resp_lib & PAN_lib>Resp_lib & PRD_lib<Resp_lib);
    replace bet_part = 1 if (PRD_lib > Resp_lib & PAN_lib>Resp_lib & PRI_lib<Resp_lib) ;
    recode bet_part (.= 0) if bet_part!=1 & PAN_lib!=. | bet_part!=1 & PRI_lib!=. | bet_part!=1 & PRD_lib!=. | bet_part!=1 & Resp_lib!=. ;
} ;

foreach x of varlist unique_id { ;

    replace bet_part_bar = 1 if (PAN_lib_bar > Resp_lib & PRI_lib_bar<Resp_lib & PRD_lib_bar<Resp_lib) ;
    replace bet_part_bar = 1 if (PRI_lib_bar > Resp_lib & PAN_lib_bar<Resp_lib & PRD_lib_bar<Resp_lib) ;
    replace bet_part_bar = 1 if (PRD_lib_bar > Resp_lib & PAN_lib_bar<Resp_lib & PRI_lib_bar<Resp_lib) ;
    replace bet_part_bar = 1 if (PAN_lib_bar > Resp_lib & PRI_lib_bar>Resp_lib & PRD_lib_bar<Resp_lib) ;
    replace bet_part_bar = 1 if (PRI_lib_bar > Resp_lib & PAN_lib_bar>Resp_lib & PRD_lib_bar<Resp_lib) ;
    replace bet_part_bar = 1 if (PRD_lib_bar > Resp_lib & PAN_lib_bar>Resp_lib & PRI_lib_bar<Resp_lib) ;
    recode bet_part_bar (.= 0) if bet_part!=1 & Resp_lib!=. ;
};

tab bet_part bet_part_bar;

/* Distance+Uncertainty measures */

gen DU_PAN = (PAN_dist + U_PAN) if proyecto=="B2";
gen DU_PRI = (PRI_dist + U_PRI) if proyecto=="B2";
gen DU_PRD = (PRD_dist + U_PRD) if proyecto=="B2";
gen DU_FCH = (FCH_dist + U_FCH) if proyecto=="B2";
gen DU_RMP = (RMP_dist + U_RMP) if proyecto=="B2";
gen DU_AMLO = (AMLO_dist + U_AMLO) if proyecto=="B2";

tab1 DU_PAN DU_PRI DU_PRD ;

/* Regional dummies */

recode region (1 = 1) (2/5 = 0), gen(nwest) ;
recode region (2 = 1) (1 3/5=0),gen(neast) ;
recode region (3 = 1) (1/2 4/5 = 0), gen(seast) ;
recode region (4 = 1) (1/3 5 = 0), gen(swest) ;
recode region (5 = 1) (1/4 = 0), gen(center) ;

tab1 nwest neast seast swest center ;

/* Urban dummies */

recode urbanicity (2/3 = 0), gen(urban) ;
recode urbanicity (2=1) (1/3 = 0), gen(rural) ;

tab1 urban rural ;


/* Cluster-effects dummies */

local c = 2 ;
while (`c' <= 200) {;
    generate clus`c' = 0 ;
    replace clus`c' = 1 if (punto == `c') ;
    local c = `c' + 1 ;
};

/* Questionnaire-effects dummies */

local q = 2 ;
while (`q' <= 4) {;
    generate quest`q' = 0 ;
    replace quest`q' = 1 if (cuest == `q') ;
    local q = `q' + 1 ;
};

/* Missing y indicators */

gen miss_p = 0;
gen miss_d = 0 ;
replace miss_p = 1 if vote_pres == . ;
replace miss_d = 1 if vote_dep == . ;


*********************************;
* KEEP NEEDED VARIABLES         *;
*********************************;
order unique_id ;
drop  folio edo mpio secc dto_nvo proyecto punto cuest *_lib_bar clus146 center urbanicity region ;
label drop _all ;

save exitpoll06.dta, replace nolabel;
log close ;
clear;
exit;
