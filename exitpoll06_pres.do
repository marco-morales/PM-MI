version 9
drop _all
#delimit ;
set more off ;
capture log close ;
log using H:\Parametria\Data\exitpoll06_pres.log, replace ;
set more off ;

*     ***************************************************************** *;
*       File-Name:      exitpoll06_pres.do                              *;
*       Date:           Feb 10, 2007                                    *;
*       Author:         MM                                              *;
*       Purnege:        Estimates models MNP models for 2006 election   *;
*       Input File:     exit_long1-10.dta                               *;
*       Output Files:   exitpoll06_pres.log                             *;
*       Data Output:    pres_results.dta (summary estimates)            *;
*                       pres_betas.dta  (beta matrix)                   *;
*                       pres_covmat.dta (covariance matrix)             *;
*                       beta_pres.dta (simulated betas)                 *;
*       Previous file:  none                                            *;
*       Status:         WHONOZ?                                         *;
*       Machine:        Room 320                                        *;
*     ****************************************************************  *;
mata: mata clear ;
set mem 256M ;
cd "H:\Parametria\Data\MI_070401";

*************************************;
* PRESIDENTIAL ELECTION MODEL       *;
*************************************;

/* Define covariance matrix */

*matrix define omega = (1,.,.\.,1,.\0,.,1) ; /* no corr PAN-PRD */

matrix define omega = (1,.,.\0,1,.\.,.,1) ; /* no corr PRI-PAN */

matrix list omega ;

local a = 1 ;

while (`a' <= 10) {;

use exit_long`a'.dta, clear ;

asmprobit pres D_cand c_ad_neg c_ad_pos if vote_pres<4 & miss_p==0, 
    robust case(unique_id) casevars(ad_scholar ad_schools ad_insure
    ad_housing ad_oport scholar schools insure housing oport id_pan
    id_pri id_prd retro_g retro_b prosp_g prosp_b app_g app_b
    u_fch u_amlo u_rmp age1824 age2540 age4160 
    ed_prim ed_sec ed_high ed_col female lo_class mid_class 
    nwest neast seast swest urban rural) alternatives(party) 
    base(2) stddev(homoskedastic) correlation(fixed omega);

matrix b`a'=get(_b) ;
matrix V`a'=get(VCE) ;
scalar num = e(k) ;
matrix LL`a' = e(ll) ;
matrix CHI`a' = e(chi2) ;
matrix MFD = e(df_m) ;
matrix N = e(N_case) ;


test ad_scholar ad_schools ad_insure ad_housing ad_oport ;
test scholar schools insure ;

est store pres`a' ;
estat covariance ;
estat correlation ;

local a = `a' + 1 ;
} ;

estimates dir ;


************************************;
* COMBINE ESTIMATES                *;
************************************;

tempname TRAT DF PVAL num ;

/* POINT ESTIMATE OF LOG-LIKELIHOOD */

matrix LL = ((LL1+LL2+LL3+LL4+LL5+LL6+LL7+LL8+LL9+LL10)/10) ;

/* POINT ESTIMATE OF CHI-SQUARED */

matrix CHI = ((CHI1+CHI2+CHI3+CHI4+CHI5+CHI6+CHI7+CHI8+CHI9+CHI10)/10) ;

/* POINT ESTIMATE OF BETA */

matrix beta = ((b1+b2+b3+b4+b5+b6+b7+b8+b9+b10)/10) ;


/* OVERALL VARIANCE OF BETA */
/* a) generate within variance */

matrix Vwith  = (V1+V2+V3+V4+V5+V6+V7+V8+V9+V10)/10 ;

/* b) generate in-between variance */

local x = 1 ;
while (`x' <= 10) {;
    matrix Vin`x' = (b`x'-beta)'*(b`x'-beta) ;
local x = `x' + 1 ;
} ;

matrix Vin = ((Vin1+Vin2+Vin3+Vin4+Vin5+Vin6+Vin7+Vin8+Vin9+Vin10)/9)*(1.10) ;

/* add within and in-between variance */

matrix Var = Vwith+Vin ;


/* Generate 1xn matrix of standard errors */

matrix SE = vecdiag(cholesky(Var)) ;

/* Generate t-ratios */

local i = 1 ;
while (`i' <= num ) {;
    matrix TRAT`i' = beta[1,`i']/SE[1,`i'] ;
local i = `i' + 1 ;
};

local i = 2 ;
matrix `TRAT' = TRAT1 ;
while (`i' <= num) {;
    matrix `TRAT' = (`TRAT',TRAT`i') ;
local i = `i' + 1 ;
};

matrix TRAT = `TRAT' ;

/* Generate degrees of freedom */

local d = 1 ;
while (`d' <= num) {;
    matrix DF`d' = 9*(1+Vwith[`d',`d']/Vin[`d',`d'])^2 ;
local d = `d' + 1 ;
};

local i = 2 ;
matrix `DF' = DF1 ;
while (`i' <= num) {;
    matrix `DF' = (`DF',DF`i') ;
local i = `i' + 1 ;
};

matrix DF = `DF' ;

/* Generate p-values */

local j = 1 ;
while (`j' <= num ) {;
    matrix PVAL`j' = tprob(DF[1,`j'],TRAT[1,`j']);
local j = `j' + 1 ;
};

local i = 2 ;
matrix `PVAL' = PVAL1 ;
while (`i' <= num ) {;
    matrix `PVAL' = (`PVAL',PVAL`i') ;
local i = `i' + 1 ;
};

matrix PVAL = `PVAL' ;

/* Gathers all info in one matrix */

matrix PAR = beta',SE',TRAT',PVAL' ;

matrix colnames PAR = est se t-ratio p-value ;

matrix list PAR ; /* Parameters */

matrix list LL ;  /* Log-likelihood */

matrix list CHI ; /* Chi-squared for null model */

matrix list N ; /* Number of observations */

svmat double PAR ;
ren PAR1 est ;
ren PAR2 se;
ren PAR3 tratio ;
ren PAR4 pvalue ;
keep  est  se tratio  pvalue ;
save pres_betas.dta, replace ;

scalar rhoPANPRD = tanh(beta[1,num-1]) ; 

/* estimate of rho_PANPRD */ scalar list rhoPANPRD ;

scalar rhoPRIPRD = tanh(beta[1,num]) ;   

/* estimate of rho_PRIPRD */ scalar list rhoPRIPRD ;

scalar rhoPANPRI = 0 ;

/* assumed value of rho_PANPRI */ scalar list rhoPANPRI ;

svmat double beta ;
save pres_betas.dta, replace ;

svmat double Var ;
save pres_covmat.dta, replace ;

*********************************;
* SIMULATED BETAS               *;
*********************************;

/* Generate the distributions for the estimated parameters */
/* Generate 7,764 draws from a multivariate normal          */
/* distribution with mean beta and variance Var from the   */
/* combined estimates from the model above                 */

preserve;
drawnorm p1-p83, n(7764) means(beta) cov(Var) clear;
keep p1-p81 ;
gen rhoPANPRD_p = rhoPANPRD ;
gen rhoPRIPRD_p = rhoPRIPRD ;
gen rhoPANPRI_p = rhoPANPRI ;

save beta_pres, replace;

summ ;

log close ;
clear ;
exit ;
