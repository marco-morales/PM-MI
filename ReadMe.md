
### Code for data processing, multiple imputation and analysis for a method that couples Planned Missingness with Multiple Imputation on Exit Polls 

The method was originally introduced in:

>Bautista, Ren&eacute;, Marco A. Morales, Francisco Abundis and Mario Callegaro. 2008. Exit polls as valuable tools to understand voting behavior: Using an advanced design in Mexico - Measurement Error. In [Elections and Exit polling](http://www.wiley.com/WileyCDA/WileyTitle/productCd-0470291168.html), ed. Fritz Scheuren and Wendy Alvey. New York, NY: John Wiley & Sons 

and further upacked/developed in the companion paper ['Planned Missingness with Multiple Imputation: an Application to Election Day Surveys'](http://marco-morales.com/documents/wp/PMMI_pub_140920.pdf) 

Each file on the repo performs the particular tasks described below:

- exitpoll06.do :  performs initial data manipulations to generate file in preparation for MI (Stata do-file)
- splitmex06_MI.R : perfoms multiple imputation on the full data file using Amelia II (R file)
- MI_reshape.do : performs computations and data reshaping to long format on each multiply imputed file  (Stata do-file) 
- exitpoll06_pres.do : performs vote choice analysis using multinomial probit model on each of the MI datasets and combines results using 'Rubin rules' (Stata do-file)
- exitpoll06_sim_pres.do : generates simulations from estimated models to compute diverse first differences of interest (Stata do-file)
- coef_graphs_110717.do : graphs first differences on a single file appearing as Figure 3 on the paper (Stata do-file)
