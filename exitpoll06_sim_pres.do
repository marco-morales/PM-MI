version 9
drop _all
#delimit ;
set more off ;
capture log close ;
log using H:\Parametria\Data\exitpoll06_sim_pres.log, replace ;
set more off ;

*     ***************************************************************** *;
*       File-Name:      exitpoll06_sim_pres.do                          *;
*       Date:           April 10, 2007                                  *;
*       Author:         MM                                              *;
*       Purnege:        Generates simulations for MNP models            *;
*       Input File:     beta_pres.dta  (produced by exitpoll06_pres.do) *;
*       Output Files:   exitpoll06_sim_pres.log                         *;
*       Data Output:    none                                            *;
*       Previous file:  none                                            *;
*       Status:         WHONOZ?                                         *;
*       Machine:        Room 320                                        *;
*     ****************************************************************  *;
mata: mata clear ;
set mem 256M ;
cd "H:\Parametria\Data\MI_070401";

use beta_pres.dta, clear ;

summ rhoPANPRD, meanonly ;
scalar rhoPANPRD = r(mean) ; 
scalar list rhoPANPRD ;

summ rhoPRIPRD, meanonly ;
scalar rhoPRIPRD = r(mean) ; 
scalar list rhoPRIPRD ;

summ rhoPANPRI, meanonly ;
scalar rhoPANPRI = r(mean) ; 
scalar list rhoPANPRI ;

*********************************;
* SIMULATIONS                   *;
*********************************;

/* Generate the utilities for each party for given values */
/* of each variable that simulate an average individual   */
/* with different values for the variable of interest     */

/* SETTING VALUES FOR PAN */

* Negative ad for PAN w typicial subject *;

gen neg_pan = (p1*8.978)+(p2*1)+(p3*0)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1) ;
    
gen neg_pan_b = (p1*8.978)+(p2*0)+(p3*0)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1) ;
     
* Positive ad for PAN w typicial subject *;

gen pos_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1) ;
    
gen pos_pan_b = (p1*8.978)+(p2*0)+(p3*0)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1) ;
    
* Oportunidades for PAN w typical subject *;

gen op_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;

gen nop_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1) ;

* Retrospective economic evaluation for PAN w typicial subject *;

gen rg_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;

gen rg_pan_b = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*0)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;
    
gen rb_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p18*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;

* Prospective economic evaluation for PAN w typicial subject *;

gen pg_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;

gen pg_pan_b = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*0)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;
    
gen pb_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p20*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;

* Evaluation of the president for PAN w typicial subject *;

gen evg_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;

gen evg_pan_b = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;
    
gen evb_pan = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p18*1)+(p19*1)+
    (p22*1)+(p23*6.863)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1)+(p13*1) ;

* Evaluations for PAN uncertrainty w typical subject *;

local a = 0 ;
while `a' <= 36 { ;
    gen u_pan_`a' = (p1*8.978)+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*`a')+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1) ;
local a = `a' + 1 ;
};

* Evaluations for PAN distance w typical subject *;

local a = 0 ;
while `a' <= 36 { ;
    gen dist_pan_`a' = (p1*`a')+(p2*0)+(p3*1)+(p15*3)+(p17*1)+(p19*1)+
    (p21*1)+(p23*8.978)+(p24*6.895)+(p25*6)+(p28*1)+(p29*1)+
    (p35*1)+(p38*1)+(p40*1)+(p42*1) ;
local a = `a' + 1 ;
};


/* SETTING VALUES FOR PRD */

* Negative ad for PRD w typicial subject *;

gen neg_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
    
gen neg_prd_b = (p1*11.269)+(p2*0)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;

* Positive ad for PRD w typicial subject *;

gen pos_prd = (p1*11.269)+(p2*0)+(p3*1)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
    
gen pos_prd_b = (p1*11.269)+(p2*0)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
    
* Oportunidades for PRD w typical subject *;

gen op_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1)+(p52*1) ;

gen nop_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
    
* Retrospective economic evaluation for PRD w typicial subject *;

gen rg_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;

gen rg_prd_b = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*0)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
    
gen rb_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p57*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;

* Prospective economic evaluation for PRD w typicial subject *;

gen pg_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;

gen pg_prd_b = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*0)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
    
gen pb_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p59*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;

* Evaluation of the president for PRD w typicial subject *;

gen evg_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;

gen evg_prd_b = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p60*0)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
    
gen evb_prd = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p61*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;

* Evaluations for PRD uncertrainty w typical subject *;

local b = 0 ;
while `b' <= 36 { ;
    gen u_prd_`b' = (p1*11.269)+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p61*1)+(p62*6.863)+(p63*`b')+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
local b = `b' + 1 ;
};

* Evaluations for PRD distance w typical subject *;

local b = 0 ;
while `b' <= 36 { ;
    gen dist_prd_`b' = (p1*`b')+(p2*1)+(p3*0)+(p54*3)+(p56*1)+(p58*1)+
    (p61*1)+(p62*6.863)+(p63*6.895)+(p64*6)+(p67*1)+(p68*1)+
    (p74*1)+(p77*1)+(p79*1)+(p81*1) ;
local b = `b' + 1 ;
};


/* EXPECTED PROBABILITIES FROM SIMULATIONS */

/* Compute the probabilities of voting for each one of the */
/* candidates from the normal distribution using computed  */
/* rho                                                     */

/* Probabilites for PAN */

gen p_neg_pan    = norm(neg_pan/sqrt(2-2*rhoPANPRI)) ;
gen p_neg_pan_b  = norm(neg_pan_b/sqrt(2-2*rhoPANPRI)) ;

gen p_pos_pan    = norm(pos_pan/sqrt(2-2*rhoPANPRI)) ;
gen p_pos_pan_b  = norm(pos_pan_b/sqrt(2-2*rhoPANPRI)) ;

gen p_op_pan     = norm(op_pan/sqrt(2-2*rhoPANPRI)) ;
gen p_nop_pan_b  = norm(nop_pan/sqrt(2-2*rhoPANPRI)) ;

gen p_rg_pan    = norm(rg_pan/sqrt(2-2*rhoPANPRI)) ;
gen p_rg_pan_b  = norm(rg_pan_b/sqrt(2-2*rhoPANPRI)) ;
gen p_rb_pan    = norm(rb_pan/sqrt(2-2*rhoPANPRI)) ;

gen p_pg_pan    = norm(pg_pan/sqrt(2-2*rhoPANPRI)) ;
gen p_pg_pan_b  = norm(pg_pan_b/sqrt(2-2*rhoPANPRI)) ;
gen p_pb_pan    = norm(pb_pan/sqrt(2-2*rhoPANPRI)) ;

gen p_evg_pan    = norm(evg_pan/sqrt(2-2*rhoPANPRI)) ;
gen p_evg_pan_b  = norm(evg_pan_b/sqrt(2-2*rhoPANPRI)) ;
gen p_evb_pan    = norm(evb_pan/sqrt(2-2*rhoPANPRI)) ;

local c = 0 ;
while `c' <= 36 { ;
    gen p_u_pan_`c' = norm(u_pan_`c'/sqrt(2-2*rhoPANPRI)) ;
local c = `c' + 1 ;
};

local c = 0 ;
while `c' <= 36 { ;
    gen p_dis_pan_`c' = norm(dist_pan_`c'/sqrt(2-2*rhoPANPRI)) ;
local c = `c' + 1 ;
};


/* Probabilites for PRD */

gen p_neg_prd    = norm(neg_prd/sqrt(2-2*rhoPRIPRD)) ;
gen p_neg_prd_b  = norm(neg_prd_b/sqrt(2-2*rhoPRIPRD)) ;

gen p_pos_prd    = norm(pos_prd/sqrt(2-2*rhoPRIPRD)) ;
gen p_pos_prd_b  = norm(pos_prd_b/sqrt(2-2*rhoPRIPRD)) ;

gen p_op_prd     = norm(op_prd/sqrt(2-2*rhoPRIPRD)) ;
gen p_nop_prd_b  = norm(nop_prd/sqrt(2-2*rhoPRIPRD)) ;

gen p_rg_prd    = norm(rg_prd/sqrt(2-2*rhoPRIPRD)) ;
gen p_rg_prd_b  = norm(rg_prd_b/sqrt(2-2*rhoPRIPRD)) ;
gen p_rb_prd    = norm(rb_prd/sqrt(2-2*rhoPRIPRD)) ;

gen p_pg_prd    = norm(pg_prd/sqrt(2-2*rhoPRIPRD)) ;
gen p_pg_prd_b  = norm(pg_prd_b/sqrt(2-2*rhoPRIPRD)) ;
gen p_pb_prd    = norm(pb_prd/sqrt(2-2*rhoPRIPRD)) ;

gen p_evg_prd    = norm(evg_prd/sqrt(2-2*rhoPRIPRD)) ;
gen p_evg_prd_b  = norm(evg_prd_b/sqrt(2-2*rhoPRIPRD)) ;
gen p_evb_prd    = norm(evb_prd/sqrt(2-2*rhoPRIPRD)) ;

local d = 0 ;
while `d' <= 36 { ;
    gen p_u_prd_`d' = norm(u_prd_`d'/sqrt(2-2*rhoPRIPRD)) ;
local d = `d' + 1 ;
};

local d = 0 ;
while `d' <= 36 { ;
    gen p_dis_prd_`d' = norm(dist_prd_`d'/sqrt(2-2*rhoPRIPRD)) ;
local d = `d' + 1 ;
};

/* Probabilities for PRI */

gen p_neg_pri    = 1-p_neg_prd-p_neg_pan ;
gen p_neg_pri_b  = 1-p_neg_prd_b-p_neg_pan_b ;

gen p_pos_pri    = 1-p_pos_prd-p_pos_pan ;
gen p_pos_pri_b  = 1-p_pos_prd_b-p_pos_pan_b;

gen p_op_pri     = 1-p_op_prd-p_op_pan ;
gen p_nop_pri_b  = 1-p_nop_prd-p_nop_pan ;

gen p_rg_pri    = 1-p_rg_prd-p_rg_pan ;
gen p_rg_pri_b  = 1-p_rg_prd_b-p_rg_pan ;
gen p_rb_pri    = 1-p_rb_prd-p_rb_pan ;

gen p_pg_pri    = 1-p_pg_prd-p_pg_pan ;
gen p_pg_pri_b  = 1-p_pg_prd_b-p_pg_pan ;
gen p_pb_pri    = 1-p_pb_prd-p_pb_pan ;

gen p_evg_pri    = 1-p_evg_prd-p_evg_pan ;
gen p_evg_pri_b  = 1-p_evg_prd_b-p_evg_pan_b ;
gen p_evb_pri    = 1-p_evb_prd-p_evb_pan;


/* FIRST DIFFERENCES */

/* For PAN */

gen d_neg_pan = p_neg_pan-p_neg_pan_b ;

gen d_pos_pan = p_pos_pan-p_pos_pan_b ;

gen d_op_pan = p_op_pan-p_nop_pan ;

gen d_rg_rb_pan =  p_rg_pan - p_rb_pan ;

gen d_rg_pan = p_rg_pan - p_rg_pan_b ;

gen d_rb_pan = p_rb_pan - p_rg_pan_b ;

gen d_pg_pb_pan =  p_pg_pan - p_pb_pan ;

gen d_pg_pan = p_pg_pan - p_pg_pan_b ;

gen d_pb_pan = p_pb_pan - p_pg_pan_b ;

gen d_evg_rb_pan =  p_evg_pan - p_evb_pan ;

gen d_evg_pan = p_evg_pan - p_evg_pan_b ;

gen d_evb_pan = p_evb_pan - p_evg_pan_b ;

gen d_upan = p_u_pan_0-p_u_pan_36 ;

gen d_dispan = p_dis_pan_0-p_dis_pan_36 ;


/* For PRD */

gen d_neg_prd = p_neg_prd-p_neg_prd_b ;

gen d_pos_prd = p_pos_prd-p_pos_prd_b ;

gen d_op_prd = p_op_prd-p_nop_prd ;

gen d_rg_rb_prd =  p_rg_prd - p_rb_prd ;

gen d_rg_prd = p_rg_prd - p_rg_prd_b ;

gen d_rb_prd = p_rb_prd - p_rg_prd_b ;

gen d_pg_pb_prd =  p_pg_prd - p_pb_prd ;

gen d_pg_prd = p_pg_prd - p_pg_prd_b ;

gen d_pb_prd = p_pb_prd - p_pg_prd_b ;

gen d_evg_rb_prd =  p_evg_prd - p_evb_prd ;

gen d_evg_prd = p_evg_prd - p_evg_prd_b ;

gen d_evb_prd = p_evb_prd - p_evg_prd_b ;

gen d_uprd = p_u_prd_0-p_u_prd_36 ;

gen d_disprd = p_dis_prd_0-p_dis_prd_36 ;

/* For PRI */

gen d_neg_pri = p_neg_pri-p_neg_pri_b ;

gen d_pos_pri = p_pos_pri-p_pos_pri_b ;

gen d_op_pri = p_op_pri-p_nop_pri ;

gen d_rg_rb_pri =  p_rg_pri - p_rb_pri ;

gen d_rg_pri = p_rg_pri - p_rg_pri_b ;

gen d_rb_pri = p_rb_pri - p_rg_pri_b ;

gen d_pg_pb_pri =  p_pg_pri - p_pb_pri ;

gen d_pg_pri = p_pg_pri - p_pg_pri_b ;

gen d_pb_pri = p_pb_pri - p_pg_pri_b ;

gen d_evg_rb_pri =  p_evg_pri - p_evb_pri ;

gen d_evg_pri = p_evg_pri - p_evg_pri_b ;

gen d_evb_pri = p_evb_pri - p_evg_pri_b ;


***********************************************;
* DISPLAY SIMULATIONS                         *;
***********************************************;

/* EFFECTS OF NEGATIVE ADS */

* for PAN *;

summ p_neg_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_neg_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_neg_pan_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_neg_pan_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_neg_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_neg_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

* for PRD *;

summ p_neg_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_neg_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_neg_prd_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_neg_prd_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_neg_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_neg_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

* for PRI *;

summ p_neg_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_neg_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_neg_pri_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_neg_pri_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_neg_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_neg_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


/* EFFECTS OF POSITIVE ADS */

* for PAN *;

summ p_pos_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pos_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pos_pan_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pos_pan_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pos_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pos_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

* for PRD *;

summ p_pos_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pos_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pos_prd_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pos_prd_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pos_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pos_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


* for PRI *;

summ p_pos_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pos_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pos_pri_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pos_pri_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pos_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pos_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


/* EFFECTS OF OPORTUNIDADES*/

* for PAN *;

summ p_op_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_op_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_nop_pan_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_nop_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_op_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_op_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

* for PRD *;

summ p_op_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_op_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


summ p_nop_prd_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_nop_prd_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_op_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_op_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


* for PRI *;

summ p_op_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_op_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_nop_pri_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_nop_pri_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_op_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_op_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


/* RETROSPECTIVE EVALUATIONS OF THE ECONOMY */

* for PAN * ;

summ p_rg_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rg_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_rg_pan_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rg_pan_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_rb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_rg_rb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rg_rb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_rg_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rg_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_rb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


* for PRD * ;

summ p_rg_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rg_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_rg_prd_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rg_prd_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_rb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_rg_rb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rg_rb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_rg_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rg_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_rb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

* for PRI * ;

summ p_rg_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rg_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


summ p_rg_pri_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rg_pri_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_rb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_rb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_rg_rb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rg_rb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


summ d_rg_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rg_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


summ d_rb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_rb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


/* PROSPECTIVE EVALUATIONS OF THE ECONOMY */

* for PAN * ;

summ p_pg_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pg_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pg_pan_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pg_pan_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pg_pb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pg_pb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pg_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pg_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


* for PRD * ;

summ p_pg_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pg_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pg_prd_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pg_prd_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pg_pb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pg_pb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pg_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pg_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


summ d_pb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


* for PRI * ;

summ p_pg_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pg_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pg_pri_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pg_pri_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_pb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_pb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pg_pb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pg_pb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;


summ d_pg_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pg_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_pb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_pb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

/* PRESIDENTIAL EVALUATIONS  */

* for PAN * ;

summ p_evg_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evg_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_evg_pan_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evg_pan_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_evb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evg_rb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evg_rb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evg_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evg_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evb_pan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evb_pan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

* for PRD * ;

summ p_evg_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evg_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_evg_prd_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evg_prd_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_evb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evg_rb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evg_rb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evg_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evg_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evb_prd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evb_prd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

* for PRI * ;

summ p_evg_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evg_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_evg_pri_b, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evg_pri_b, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ p_evb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile p_evb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evg_rb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evg_rb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evg_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evg_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

summ d_evb_pri, meanonly ;
display "Expected value " r(mean) ;
_pctile d_evb_pri, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

/* UNCERTAINTY */

cd "H:\Parametria\P&G" ;
* for PAN *;

summ d_upan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_upan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

generate upanlo = . ;
generate upanhi = . ;
generate axis = _n-1  in 1/36 ;
local g = 0 ;
while `g' <= 36 {;
    _pctile p_u_pan_`g', p(2.5,97.5) ;
   replace upanlo = r(r1) if axis==`g' ;
   replace upanhi = r(r2) if axis==`g' ;
   local g = `g' + 1 ;
} ;
sort axis ;
twoway (rbar upanhi upanlo axis, barwidth(.2)), 
    ytitle(Pr(vote)) ylabel(0  0.5  1.0) xtitle("FCH Uncertainty") 
    xlabel(0 "Certain" 34 "Uncertain") scheme(s1mono) saving(ufch, replace);
graph2tex, epsfile(ufch) ;

* for PRD *;

summ d_uprd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_uprd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

generate uprdlo = . ;
generate uprdhi = . ;
local h = 0 ;
while `h' <= 36 {;
    _pctile p_u_prd_`h', p(2.5,97.5) ;
   replace uprdlo = r(r1) if axis==`h' ;
   replace uprdhi = r(r2) if axis==`h' ;
   local h = `h' + 1 ;
} ;
sort axis ;
twoway (rbar uprdhi uprdlo axis, barwidth(.2)), 
    ytitle(Pr(vote)) ylabel(0  0.5  1.0) xtitle("AMLO Uncertainty") 
    xlabel(0 "Certain" 34 "Uncertain") scheme(s1mono) saving(uamlo, replace);
graph2tex, epsfile(uamlo) ;


graph combine ufch.gph uamlo.gph, ycommon  scheme(s1mono) fysize(75) ;
graph2tex, epsfile(uall) ;

/* DISTANCE */

* for PAN *;

summ d_dispan, meanonly ;
display "Expected value " r(mean) ;
_pctile d_dispan, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

generate dispanlo = . ;
generate dispanhi = . ;
local g = 0 ;
while `g' <= 36 {;
    _pctile p_dis_pan_`g', p(2.5,97.5) ;
   replace dispanlo = r(r1) if axis==`g' ;
   replace dispanhi = r(r2) if axis==`g' ;
   local g = `g' + 1 ;
} ;
sort axis ;
twoway (rbar dispanhi dispanlo axis, barwidth(.2)), 
    ytitle(Pr(vote)) ylabel(0  0.5  1.0) xtitle("PAN Distance") 
    xlabel(0 "Close" 34 "Distant") scheme(s1mono) saving(dpan, replace);
graph2tex, epsfile(dpan) ;

* for PRD *;

summ d_disprd, meanonly ;
display "Expected value " r(mean) ;
_pctile d_disprd, p(2.5,97.5) ;
display "95% CI [" r(r1) ", " r(r2) "]" ;

generate disprdlo = . ;
generate disprdhi = . ;
local h = 0 ;
while `h' <= 36 {;
    _pctile p_dis_prd_`h', p(2.5,97.5) ;
   replace disprdlo = r(r1) if axis==`h' ;
   replace disprdhi = r(r2) if axis==`h' ;
   local h = `h' + 1 ;
} ;
sort axis ;
twoway (rbar disprdhi disprdlo axis, barwidth(.2)), 
    ytitle(Pr(vote)) ylabel(0  0.5  1.0) xtitle("PRD Distance") 
    xlabel(0 "Close" 34 "Distant") scheme(s1mono) saving(dprd, replace);
graph2tex, epsfile(dprd) ;


graph combine dpan.gph dprd.gph, ycommon  scheme(s1mono) fysize(75) ;
graph2tex, epsfile(dall) ;



log close ;
clear ;
exit ;
