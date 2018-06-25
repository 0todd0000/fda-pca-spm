% Statistical Parametric Mapping (SPM) T-test

%Script details and extended comments are provided in the "Notebooks" folder at:
%https://github.com/0todd0000/fda-pca-spm

clear; clc   %clear workspace
close all    %close all figures

load('Warmenhoven2018-bow-force');

spm  = spm1d.stats.ttest2(Pin_Force_Bow_Male', Pin_Force_Bow_Female');
spmi = spm.inference(0.05, 'two_tailed',true);

figure(101)
spmi.plot();
spmi.plot_threshold_label(); 
spmi.plot_p_values(); 
