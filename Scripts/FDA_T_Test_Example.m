% Functional Data Analysis (t test)

%Script details and extended comments are provided in the "Notebooks" folder at:
%https://github.com/0todd0000/fda-pca-spm

clear; clc   %clear workspace
close all    %close all figures

load('Warmenhoven2018-bow-force');

% FDA preliminary steps
time       = linspace(0, 100, 51)'; 
forcebasis = create_bspline_basis([0,100], 51, 6); 

Lfdobj              = int2Lfd(4); 
smoothing_parameter = 1e-15;
forcefdPar          = fdPar(forcebasis, Lfdobj, smoothing_parameter);

Pin_Force_Bow_Female_fd = smooth_basis(time, Pin_Force_Bow_Female, forcefdPar);
Pin_Force_Bow_Male_fd   = smooth_basis(time, Pin_Force_Bow_Male, forcefdPar);

% Functional T-Test (results plotted automatically)
tpermStr1 = tperm_fd(Pin_Force_Bow_Male_fd, Pin_Force_Bow_Female_fd, 10000, 0.05);
