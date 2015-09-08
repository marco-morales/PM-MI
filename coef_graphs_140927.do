version 13
drop _all
set more off 
capture log close 
log using /Users/marco_morales/Dropbox/Projects/PMMI/coef_graphs_140927.log, replace 

*     ***************************************************************** *;
*       File-Name:      coef_graphs_140927.do                           *;
*       Date:           Sep 27, 2014                                    *;
*       Author:         MM                                              *;
*       Purpose:        Generates graphs that present simultaneously the*;
*                       estimated first differences in probs for pres   *;
*                       and congressional vote choices from 2006 MNP    *;
*       Input File:     coefs_rec.dta                                   *;
*       Output Files:   coef_graphs_140927.log                          *;
*                       PMMI_fd.pdf                                     *;
*       Data Output:    none                                            *;
*       Previous file:  coef_graphs_110717.do                           *;
*       Status:         done                                            *;
*       Machine:        Mac                                             *;
*     ****************************************************************  *;
cd "/Users/marco_morales/Dropbox/Projects/PMMI/"

use "data/coefs_rec.dta", clear 

* Used following code to make necessary changes in coefs.dta file to get a *
* good graph. Changes order of variables and renames choices               *
* 
* recode variable (1 = 7) (2 = 8) (3 = 9) (4 = 5) (5 = 6) (6 = 3) (7 = 4) (8 = 1) (9 = 2)
* recode variable (1 = 9) (2 = 8) (3 = 7) (4 = 6) (5 = 5) (6 = 4) (7 = 3) (8 = 2) (9 = 1) 
*
* label define choice 1 "Felipe Calder`=char(151)'n (PAN)" 2 "Roberto Madrazo (PRI)" 3 "Andr`=char(142)'s Manuel L`=char(151)'pez Obrador (PRD)", replace
* label list choice
* label values choice choice


twoway 	(rbar hi_ci low_ci variable, mwidth msize(vtiny) vertical) ///
		(dot mean variable, vertical dotextend(no) ndots(0) msymbol(o) dsize(vtiny)), ///
		scheme(s1mono) plotregion(style(none)) xscale(noline) subtitle(, nobox size(small))   ///
		xlabel(9 `""Approve" "President"' 8 `""Disapprove" "President"' ///
		7 `""Positive Prospective" "Economic Evaluation"' 6 `""Negative Prospective" "Economic Evaluation"' ///
		5 `""Positive Retrospective" "Economic Evaluation"' 4 `""Negative Retrospective" "Economic Evaluation"' ///
		3 `""Positive" "Campaign"' 2 `""Negative" "Campaign"' 1 `""Recipient of" "Oportunidades"', nogrid angle(vertical) labsize(vsmall)) ///
		yline(0, lwidth(medthin) lpattern(dash) lcolor(gs8)) ylabel(-.30 -.20 -.10 0 .10 .20 .30, nogrid labsize(tiny)) xtitle(" ") ///
		by(choice, rows(3) legend(off) note(" ") noedgelabel) aspectratio(.20)
graph export PMMI_fd_vert.pdf, as(pdf) replace 

log close 
clear
exit

/* NOT USED ADDITIONAL GRAPHS */ 

twoway 	(rbar hi_ci low_ci variable, mwidth msize(vtiny) horizontal) ///
		(dot mean variable, horizontal dotextend(no) ndots(0) msymbol(O)), ///
		scheme(s1mono) plotregion(style(none)) yscale(noline) subtitle(, nobox size(small))   ///
		ylabel(9 `""Approve" "President"' 8 `""Disapprove" "President"' ///
		7 `""Positive Prospective" "Economic Evaluation"' 6 `""Negative Prospective" "Economic Evaluation"' ///
		5 `""Positive Retrospective" "Economic Evaluation"' 4 `""Negative Retrospective" "Economic Evaluation"' ///
		3 `""Positive" "Campaign"' 2 `""Negative" "Campaign"' 1 `""Recipient of" "Oportunidades"', nogrid angle(horizontal) labsize(vsmall)) ///
		xline(0, lwidth(medthin) lpattern(dash) lcolor(gs8)) xlabel(-.30 -.20 -.10 0 .10 .20 .30, nogrid labsize(vsmall)) ytitle(" ") ///
		by(choice, rows(1) legend(off) note(" "))

graph export PMMI_fd.pdf, as(pdf) replace 





twoway 	(rbar hi_ci low_ci variable, mwidth msize(vtiny) vertical) ///
		(dot mean variable, vertical dotextend(no) ndots(0) msymbol(o) dsize(vtiny)), ///
		scheme(s1mono) plotregion(style(none)) xscale(noline) subtitle(, nobox size(small))   ///
		xlabel(9 `""Approve" "President"' 8 `""Disapprove" "President"' ///
		7 `""Positive Prospective" "Economic Evaluation"' 6 `""Negative Prospective" "Economic Evaluation"' ///
		5 `""Positive Retrospective" "Economic Evaluation"' 4 `""Negative Retrospective" "Economic Evaluation"' ///
		3 `""Positive" "Campaign"' 2 `""Negative" "Campaign"' 1 `""Recipient of" "Oportunidades"', nogrid angle(vertical) labsize(vsmall)) ///
		yline(0, lwidth(medthin) lpattern(dash) lcolor(gs8)) ylabel(-.30 -.20 -.10 0 .10 .20 .30, nogrid labsize(tiny)) xtitle(" ") ///
		by(choice, rows(1) legend(off) note(" ") subtitle("Change in probability of voting for" " ", justification(center)) noedgelabel) aspectratio(.50)
graph export PMMI_fd_vert2.pdf, as(pdf) replace 






twoway (rbar hi_ci low_ci variable if choice == 1, mwidth msize(vtiny) horizontal color(blue)) ///
	   (dot mean variable if choice == 1, horizontal dotextend(no) ndots(0) msymbol(O) color(blue)) ///
	   (rbar hi_ci low_ci variable if choice == 2, mwidth msize(vtiny) horizontal color(green)) ///
	   (dot mean variable if choice == 2, horizontal dotextend(no) ndots(0) msymbol(O) color(green)) ///
	   (rbar hi_ci low_ci variable if choice == 3, mwidth msize(vtiny) horizontal color(red)) ///
	   (dot mean variable if choice ==3, horizontal dotextend(no) ndots(0) msymbol(O) color(red) ), ///
	   scheme(s1mono) plotregion(style(none)) yscale(noline) subtitle("Change in probability of voting for" " ") ///
		ylabel(9 `""Approve" "President"' 8 `""Disapprove" "President"' ///
		7 `""Positive Prospective" "Economic Evaluation"' 6 `""Negative Prospective" "Economic Evaluation"' ///
		5 `""Positive Retrospective" "Economic Evaluation"' 4 `""Negative Retrospective" "Economic Evaluation"' ///
		3 `""Positive" "Campaign"' 2 `""Negative" "Campaign"' 1 `""Recipient of" "Oportunidades"', nogrid angle(horizontal) labsize(vsmall)) ///
	   xline(0, lwidth(medthin) lpattern(dash) lcolor(gs8)) xlabel(-.30 -.20 -.10 0  .10  .20 .30, nogrid) ytitle(" ") ///
	   legend(on order(2 4 6) label(2 "Felipe Calder`=char(151)'n (PAN)") label(4 "Roberto Madrazo (PRI)") ///
	   label(6 "Andr`=char(142)'s Manuel" "L`=char(151)'pez Obrador (PRD)") row(1)  size(vsmall)) plotregion(style(none) ) 
graph export PMMI_fd_single.pdf, as(pdf) replace 



twoway (rbar hi_ci low_ci variable, mwidth msize(vtiny) vertical) 
	(dot mean variable, vertical dotextend(no) ndots(0) msymbol(O)),
	scheme(s1mono) by(choice, cols(1) legend(off) iscale(.5) note(" ") compact)
	xlabel(1 "Pos Campaign" 2 "Neg Campaign" 3 "Oportunidades" 4 "Negative Evaluation Retro eval (good)" 
	5 "Retro eval (bad)" 6 "Prosp eval (good)" 7 "Prosp eval (bad)" 8 "Pres approval (good)" 
	9 "Pres approval (bad)", nogrid angle(vertical)) ytitle("Pr(vote)") 
	yline(0, lwidth(medthin) lpattern(solid) lcolor(gs8)) ylabel(-.20 -.10 0  .10  .20, nogrid) xtitle(" ");
