
#     ***************************************************************** *;
#       File-Name:      splitmex06_MI.R                                 *;
#       Date:           Mar 05, 2007                                    *;
#       Author:         MM                                              *;
#       Purpose:        Generates MI datasets for Parametria exit poll  *;
#                       using AMELIA II                                 *;
#       Input File:     exitpoll06.dta (produced by exitpoll06.do)      *;
#       Output Files:   NONE                                            *;
#       Data Output:    exitpoll1.dta - exitpoll10.dta                  *;
#       Previous file:  none                                            *;
#       Status:         WHONOZ?                                         *;
#       Machine:        Room 320                                        *;
#     ****************************************************************  *;

# Sets a new working directory.
setwd("H:/Parametria/Data") ;

# Verifies the new working directory.
getwd() ;

# Loads program to load Stata data file.
library(foreign) ;

# Loads Amelia
library(Amelia) ;

exitpoll06<-read.dta("exitpoll06.dta") ;

# Verifies data was loaded
ls() ;
names(exitpoll06) ;

# Generates priors matrix (distribution)

pres.app.prior     <- c(0, 4, 0.821, 1.838) ;
split.priors       <- c(0, 5, 0.479, 0.499) ;
education.prior    <- c(0, 6, 3.032, 1.286) ;
income.prior       <- c(0, 7, 4.027, 1.800) ;
class.prior        <- c(0, 8, 2.149, 0.944) ;
vote.pres.prior    <- c(0, 9, 2.081, 0.969) ;
vote.dep.prior     <- c(0, 10, 2.112, 0.974) ;
ad.scholar.prior   <- c(0, 13, 0.253, 0.434) ;
ad.schools.prior   <- c(0, 14, 0.214, 0.410) ;
ad.insure.prior    <- c(0, 15, 0.284, 0.451) ;
ad.housing.prior   <- c(0, 16, 0.252, 0.434) ;
ad.oport.prior     <- c(0, 17, 0.282, 0.450) ;
scholar.prior      <- c(0, 18, 0.211, 0.408) ;
schools.prior      <- c(0, 19, 0.119, 0.324) ;
insure.prior       <- c(0, 20, 0.198, 0.398) ;
housing.prior      <- c(0, 21, 0.133, 0.339) ;
oport.prior        <- c(0, 22, 0.280, 0.449) ;
neg.ad.prior       <- c(0, 23, 4.040, 2.849) ;
pos.ad.prior       <- c(0, 24, 3.789, 2.846) ;
Resp.lib.prior     <- c(0, 25, 4.748, 2.077) ;
PAN.lib.prior      <- c(0, 26, 4.819, 2.197) ;
PRI.lib.prior      <- c(0, 27, 4.360, 2.216) ;
PRD.lib.prior      <- c(0, 28, 3.147, 2.182) ;
econ.retro.prior   <- c(0, 29, 0.119, 1.345) ;
econ.prosp.prior   <- c(0, 30, 1.053, 1.269) ;
PID.prior          <- c(0, 31, 3.972, 2.374) ;
expect.prior       <- c(0, 32, 1.968, 0.909) ;
strategic.prior    <- c(0, 33, 0.068, 0.252) ;
pol.int.prior      <- c(0, 34, 3.075, 0.822) ;
mex.dem.prior      <- c(0, 35, 0.769, 0.421) ;
FCH.lib.prior      <- c(0, 36, 4.819, 2.179) ;
RMP.lib.prior      <- c(0, 37, 4.397, 2.114) ;
AMLO.lib.prior     <- c(0, 38, 3.263, 2.219) ;
balance.prior      <- c(0, 39, 1.195, 0.396) ;
change.prior       <- c(0, 40, 0.633, 0.481) ;

priors <- rbind(pres.app.prior, vote.pres.prior, vote.dep.prior,
    ad.scholar.prior, ad.schools.prior, ad.insure.prior, 
    ad.housing.prior, ad.oport.prior, scholar.prior, 
    schools.prior, insure.prior, housing.prior,oport.prior, 
    pos.ad.prior, neg.ad.prior, Resp.lib.prior,
    PAN.lib.prior, PRI.lib.prior, PRD.lib.prior, econ.retro.prior,
    econ.prosp.prior, PID.prior, expect.prior, strategic.prior,
    pol.int.prior, mex.dem.prior, FCH.lib.prior, RMP.lib.prior,
    AMLO.lib.prior, balance.prior, change.prior); 

priors ; # verifies matrix

# Generates priors matrix (ranges)

pres.app.range     <- c(0, 4, -3, 3, 0.99) ;
split.ranges       <- c(0, 5, 0, 1, 0.99) ;
education.range    <- c(0, 6, 1, 5, 0.99) ;
income.range       <- c(0, 7, 1, 7, 0.99) ;
class.range        <- c(0, 8, 1, 5, 0.99) ;
vote.pres.range    <- c(0, 9, 1, 5, 0.99) ;
vote.dep.range     <- c(0, 10, 1, 5, 0.99) ;
ad.scholar.range   <- c(0, 13, 0, 1, 0.99) ;
ad.schools.range   <- c(0, 14, 0, 1, 0.99) ;
ad.insure.range    <- c(0, 15, 0, 1, 0.99) ;
ad.housing.range   <- c(0, 16, 0, 1, 0.99) ;
ad.oport.range     <- c(0, 17, 0, 1, 0.99) ;
scholar.range      <- c(0, 18, 0, 1, 0.99) ;
schools.range      <- c(0, 19, 0, 1, 0.99) ;
insure.range       <- c(0, 20, 0, 1, 0.99) ;
housing.range      <- c(0, 21, 0, 1, 0.99) ;
oport.range        <- c(0, 22, 0, 1, 0.99) ;
neg.ad.range       <- c(0, 23, 0, 1, 0.99) ;
pos.ad.range       <- c(0, 24, 0, 1, 0.99) ;
Resp.lib.range     <- c(0, 25, 1, 7, 0.99) ;
PAN.lib.range      <- c(0, 26, 1, 7, 0.99) ;
PRI.lib.range      <- c(0, 27, 1, 7, 0.99) ;
PRD.lib.range      <- c(0, 28, 1, 7, 0.99) ;
econ.retro.range   <- c(0, 29, -3, 3, 0.99) ;
econ.prosp.range   <- c(0, 30, -3, 3, 0.99) ;
PID.range          <- c(0, 31, 1, 8, 0.99) ;
expect.range       <- c(0, 32, 1, 5, 0.99) ;
strategic.range    <- c(0, 33, 0, 1, 0.99) ;
pol.int.range      <- c(0, 34, 2, 4, 0.99) ;
mex.dem.range      <- c(0, 35, 0, 1, 0.99) ;
FCH.lib.range      <- c(0, 36, 1, 7, 0.99) ;
RMP.lib.range      <- c(0, 37, 1, 7, 0.99) ;
AMLO.lib.range     <- c(0, 38, 1, 7, 0.99) ;
balance.range      <- c(0, 39, 0, 1, 0.99) ;
change.range       <- c(0, 40, 0, 1, 0.99) ;

range <- rbind(pres.app.range, vote.pres.range, vote.dep.range,
    ad.scholar.range, ad.schools.range, ad.insure.range, 
    ad.housing.range, ad.oport.range, scholar.range, 
    schools.range, insure.range, housing.range,oport.range, 
    pos.ad.range, neg.ad.range, Resp.lib.range,
    PAN.lib.range, PRI.lib.range, PRD.lib.range, econ.retro.range,
    econ.prosp.range, PID.range, expect.range, strategic.range,
    pol.int.range, mex.dem.range, FCH.lib.range, RMP.lib.range,
    AMLO.lib.range, balance.range, change.range); 

range ; # verifies matrix


# loads relevant information for Amelia

output<-amelia(data=exitpoll06,m=10,p2s=1,frontend=FALSE,logs=NULL,
    ts=NULL,cs=NULL,casepri=NULL,idvars=c("unique.id","miss.p",
    "miss.d"),priors=NULL,empri=13000,tolerance=0.0001,polytime=NULL,
    startvals=0,lags=NULL,leads=NULL,intercs=FALSE,archive=TRUE,
    sqrts=NULL,lgstc=NULL,noms=c("vote.pres","vote.dep","pos.ad",
    "neg.ad","PID"),incheck=T,ords=c("pres.app","scholar","schools",
    "insure","housing","oport","ad.scholar","ad.schools","ad.insure",
    "ad.housing","ad.oport","Resp.lib","PAN.lib","PRI.lib","PRD.lib",
    "FCH.lib","RMP.lib","AMLO.lib","balance","change","splitter","education",
    "econ.retro","econ.prosp","expect","strategic","pol.int","mex.dem",
    "income","class"),collect=FALSE,outname="exitpoll",write.out=TRUE,
    arglist=NULL,keep.data=TRUE) ;


# verifies data on various variables

compare.density(data=exitpoll06,output=output,var=5) ; # pres.app
compare.density(data=exitpoll06,output=output,var=10) ; # vote.pres
compare.density(data=exitpoll06,output=output,var=11) ; # vote.dep
compare.density(data=exitpoll06,output=output,var=24) ; # neg.ad
compare.density(data=exitpoll06,output=output,var=25) ; # pos.ad
compare.density(data=exitpoll06,output=output,var=26) ; # Resp.lib
compare.density(data=exitpoll06,output=output,var=27) ; # PAN.lib
compare.density(data=exitpoll06,output=output,var=28) ; # PRI.lib
compare.density(data=exitpoll06,output=output,var=29) ; # PRD.lib
compare.density(data=exitpoll06,output=output,var=30) ; # econ.retro
compare.density(data=exitpoll06,output=output,var=31) ; # econ.prosp
compare.density(data=exitpoll06,output=output,var=32) ; # PID
compare.density(data=exitpoll06,output=output,var=37) ; # FCH.lib
compare.density(data=exitpoll06,output=output,var=38) ; # RMP.lib
compare.density(data=exitpoll06,output=output,var=39) ; # AMLO.lib

# Verifies overimputations

overimpute(data=split06,output=output,var=4) ; # pres.app
overimpute(data=split06,output=output,var=9) ; # vote.pres
overimpute(data=split06,output=output,var=10) ; # vote.dep
overimpute(data=split06,output=output,var=23) ; # neg.ad
overimpute(data=split06,output=output,var=24) ; # pos.ad
overimpute(data=split06,output=output,var=25) ; # Resp.lib
overimpute(data=split06,output=output,var=26) ; # PAN.lib
overimpute(data=split06,output=output,var=27) ; # PRI.lib
overimpute(data=split06,output=output,var=28) ; # PRD.lib
overimpute(data=split06,output=output,var=31) ; # PID
overimpute(data=split06,output=output,var=36) ; # FCH.lib
overimpute(data=split06,output=output,var=37) ; # RMP.lib
overimpute(data=split06,output=output,var=38) ; # AMLO.lib
