version 9
drop _all
#delimit ;
set more off ;
capture log close ;
log using H:\Parametria\Data\MI_reshape.log, replace ;
set more off ;

*     ***************************************************************** *;
*       File-Name:      MI_reshape.do                                   *;
*       Date:           Feb 05, 2007                                    *;
*       Author:         MM                                              *;
*       Purpose:        Rehsapes database into individual-specific and  *;
*                       candidate-specific formats for MNP analysis of  *;
*                       single-office vote and stv                      *;
*       Input File:     exitpoll1-10.csv (produced by exitpoll06_MI.R)  *;
*       Output Files:   MI_reshape.log                                  *;
*       Data Output:    exit_long1-10.dta                               *;
*       Previous file:  none                                            *;
*       Status:         WHONOZ?                                         *;
*       Machine:        Room 320                                        *;
*     ****************************************************************  *;

set mem 256m ;
cd "H:\Parametria\Data\MI_070401" ;

******************************************************************;
* RECOMPUTES VARIABLES FOR PRESIDENTIAL/CONGRESSIONAL VOTE       *;
******************************************************************;

local a = 1 ;

while (`a' <= 10) {;

insheet using exitpoll`a'.csv, delimiter(",") clear ;

drop v1 clus* pandist pridist prddist fchdist rmpdist amlodist 
    upan upri uprd ufch urmp uamlo votesplit libextreme polbal dist 
    betpart betpartbar dupan dupri duprd dufch durmp duamlo votedf pond ;

ren uniqueid unique_id ;
ren presapp pres_app ;
ren votepres vote_pres ;
ren votedep  vote_dep ;
ren adscholar ad_scholar ;
ren adschools ad_schools; 
ren adinsure ad_insure ;
ren adhousing ad_housing ;
ren adoport ad_oport ;
ren negad neg_ad ;
ren posad pos_ad ;
ren resplib resp_lib ;
ren panlib pan_lib ;
ren prilib pri_lib ;
ren prdlib prd_lib ;
ren econretro econ_retro ;
ren econprosp econ_prosp ;
ren polint pol_int ;
ren mexdem mex_dem ;
ren fchlib fch_lib ;
ren rmplib rmp_lib ;
ren amlolib amlo_lib ;
ren missp miss_p ;
ren missd miss_d ;    
 
    
/* Computes ideological distances */

gen pan_dist = (resp_lib - pan_lib)^2 ;
gen pri_dist = (resp_lib - pri_lib)^2 ;
gen prd_dist = (resp_lib - prd_lib)^2 ;
gen fch_dist = (resp_lib - fch_lib)^2 ;
gen rmp_dist = (resp_lib - rmp_lib)^2 ;
gen amlo_dist = (resp_lib - amlo_lib)^2 ;

tab1 pan_dist pri_dist prd_dist fch_dist amlo_dist rmp_dist ;

/* Computes ucertainty measures */

gen u_pan = (pan_lib-4.819986)^2 ;
gen u_pri = (pri_lib-4.360993)^2 ;
gen u_prd = (prd_lib-3.147459)^2 ;
gen u_fch = (fch_lib-4.81973)^2 ;
gen u_rmp = (rmp_lib-4.397153)^2 ;
gen u_amlo = (amlo_lib-3.263721)^2 ;

tab1 u_pan u_pri u_prd u_fch u_rmp u_amlo ;

/* Distance+Uncertainty measures */

gen du_pan = (pan_dist + u_pan) ;
gen du_pri = (pri_dist + u_pri) ;
gen du_prd = (prd_dist + u_prd) ;
gen du_fch = (fch_dist + u_fch) ;
gen du_rmp = (rmp_dist + u_rmp) ;
gen du_amlo = (amlo_dist + u_amlo) ;

tab1 du_pan du_pri du_prd ;

*********************************;
* NEW VARIABLES                 *;
*********************************;

/*Sociodemographics */

recode age (18/24 = 1) (25/99 = 0), gen(age1824) ;
recode age (25/40 = 1) (18/24 41/99 = 0), gen(age2540) ;
recode age (41/60 = 1) (18/40 61/99 = 0), gen(age4160) ;
recode age (61/99 = 1) (18/60 = 0), gen(age60plus) ;

recode education (2/5 = 0) , gen(ed_none);
recode education (2 = 1) (1 3/5 = 0) , gen(ed_prim);
recode education (3 = 1) (1/2 4/5 = 0), gen(ed_sec);
recode education (4 = 1) (1/3 5 = 0), gen(ed_high);
recode education (5 = 1) (1/4 = 0), gen(ed_col);

recode class (1/2 = 1) (3/5 = 0), gen(lo_class) ;
recode class (3 = 1) (1/3 4/5 = 0), gen(mid_class) ;
recode class (4/5 = 1) (1/3 = 0), gen(hi_class) ;

tab1 female age1824 age2540 age4160 age60plus ed_none ed_prim ed_sec ed_high ed_col ;

/* Party ID */

recode pid (1 = 3) (2 = 1) (3/8 = 0), gen(id_pan);
recode pid (3 = 3) (4 = 1) (1/2 5/8 = 0), gen(id_pri);
recode pid (5 = 3) (6 = 1) (1/4 7/8 = 0), gen(id_prd);
recode pid (1 3 5 = 3) (2 4 6 = 1) (7/8 = 0), gen(id_str);

tab1 id_pan id_pri id_prd id_str ;

/* Economic Evaluations */

recode econ_retro (3 1 = 1) (0 -1 -3 = 0), gen(retro_g) ;
recode econ_retro (-3 -1 = 1) (0 1 3 = 0), gen(retro_b) ;
recode econ_prosp (3 1 = 1) (0 -1 -3 = 0), gen(prosp_g) ;
recode econ_prosp (-3 -1 = 1) (0 1 3 = 0), gen(prosp_b) ;

tab1 retro_g retro_b prosp_g prosp_b ;

/* Presidential Approval */

recode pres_app (3 1 = 1) (0 -1 -3 = 0), gen(app_g) ;
recode pres_app (-3 -1 = 1) (0 1 3 = 0), gen(app_b) ;

tab1 app_g app_b ;

***********************************;
* RESHAPES DATASET TO GENERATE    *;
* CHOICE-SPECIFIC VARIABLES       *;
***********************************;

/* Generate vote choices */

recode vote_pres (1=1) (2/3 4/5 =0), gen(pres1);
recode vote_pres (2=1) (1 3 4/5 =0), gen(pres2);
recode vote_pres (3=1) (1/2 4/5 =0), gen(pres3);

recode vote_dep (1=1) (2/3 4/5 =0), gen(dep1);
recode vote_dep (2=1) (1 3 4/5 =0), gen(dep2);
recode vote_dep (3=1) (1/2 4/5 =0), gen(dep3);

ren  pan_dist D_part1;
ren  pri_dist D_part2;
ren  prd_dist D_part3;

ren fch_dist D_cand1;
ren rmp_dist D_cand2 ;
ren amlo_dist D_cand3 ;

ren du_pan du_part1;
ren du_pri du_part2 ;
ren du_prd du_part3 ;

ren du_fch du_cand1 ;
ren du_rmp du_cand2 ;
ren du_amlo du_cand3 ; 

recode neg_ad (1=1) (2/9 =0), gen(c_ad_neg1);
recode neg_ad (2=1) (1 3/9 =0), gen(c_ad_neg2);
recode neg_ad (3=1) (1/2 4/9 =0), gen(c_ad_neg3);

recode pos_ad (1=1) (2/9 =0), gen(c_ad_pos1);
recode pos_ad (2=1) (1 3/9 =0), gen(c_ad_pos2);
recode pos_ad (3=1) (1/2 4/9 =0), gen(c_ad_pos3);

recode neg_ad (7=1) (1/6 8/9 =0), gen(p_ad_neg1);
recode neg_ad (8=1) (1/7 9 = 0), gen(p_ad_neg2);
recode neg_ad (9=1) (1/8  = 0), gen(p_ad_neg3);

recode pos_ad (7=1) (1/6 8/9 = 0), gen(p_ad_pos1);
recode pos_ad (8=1) (1/7 9 =0), gen(p_ad_pos2);
recode pos_ad (9=1) (1/8 =0), gen(p_ad_pos3);

summ ;

reshape long pres dep D_part D_cand c_ad_neg c_ad_pos p_ad_neg p_ad_pos du_cand du_part, i(unique_id) j(party) ;

**********************************;
* SAVES RESHAPED DATA            *;
**********************************;

keep unique_id party female pres_app ad_scholar ad_schools ad_insure ad_housing 
    ad_oport scholar schools insure housing oport econ_retro econ_prosp balance change 
    D_part D_cand u_pan u_pri u_prd u_fch u_rmp u_amlo du_cand du_part 
    age1824 age2540 age4160 age60plus ed_none ed_prim ed_sec ed_high ed_col 
    id_pan id_pri id_prd id_str pres dep c_ad_neg c_ad_pos p_ad_neg p_ad_pos
    lo_class mid_class hi_class vote_pres vote_dep  miss_p miss_d
    retro_g retro_b prosp_g prosp_b econ_retro econ_prosp app_g app_b  
    nwest neast seast swest urban rural quest2 quest3 quest4;

save exit_long`a'.dta, replace ;

local a = `a' + 1 ;
} ;

log close ;
clear;
exit;

