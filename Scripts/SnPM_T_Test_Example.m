% Statistical Non-Parametric Mapping (SnPM) T-test

%Script details and extended comments are provided in the "Notebooks" folder at:
%https://github.com/0todd0000/fda-pca-spm

clear; clc   %clear workspace
close all    %close all figures

load('Warmenhoven2018-bow-force');

snpm  = spm1d.stats.nonparam.ttest2(Pin_Force_Bow_Male', Pin_Force_Bow_Female');
snpmi = snpm.inference(0.05, 'two_tailed',true, 'force_iterations',true, 'iterations', 10000);

figure(101)
snpmi.plot();
snpmi.plot_threshold_label(); 
snpmi.plot_p_values(); 
