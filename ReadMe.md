
# September 05, 2015
# Code for data processing, multiple imputation and analysis presented on 
the paper 'Planned Missingness with Multiple Imputation: an Application to
Election Day Surveys' 

Each file performs the particular tasks described below:

- exitpoll06.do :  performs initial data manipulations to generate file in preparation for MI (Stata do-file)
- splitmex06_MI.R : perfoms multiple imputation on the full data file using Amelia II (R file)
- MI_reshape.do : performs computations and data reshaping to long format on each multiply imputed file  (Stata do-file) 
- exitpoll06_pres.do : performs vote choice analysis using multinomial probit model on each of the MI datasets and combines results using 'Rubin rules' (Stata d0-file)
- exitpoll06_sim_pres.do : generates simulations from estimated models to compute diverse first differences of interest (Stata d0-file)
- coef_graphs_110717.do : graphs first differences on a single file appearing as Figure 3 on the paper (Stata do-file)