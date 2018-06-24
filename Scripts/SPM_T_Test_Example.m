% Statistical Parametric Mapping (SPM) T-test

%Script details and extended comments are provided in:
% ./Notebook/FDA-PCA-SPM.html
% available at https://github.com/0todd0000/fda-pca-spm

clear; clc   %clear workspace
close all    %close all figures

load('Simulated_Data');

spm1       = spm1d.stats.ttest2(Pin_Force_Bow_Male', Pin_Force_Bow_Female');
spmi1      = spm1.inference(0.05, 'two_tailed',true);

figure(101)
spmi1.plot();
spmi1.plot_threshold_label(); 
spmi1.plot_p_values(); 
