% Functional Data Analysis (t test)

%Script details and extended comments are provided in:
% ./Notebook/FDA-PCA-SPM.html
% available at https://github.com/0todd0000/fda-pca-spm

clear; clc   %clear workspace
close all    %close all figures

load('Simulated_Data');

% FDA preliminary steps
time = linspace(0, 100, 51)'; 
forcebasis = create_bspline_basis([0,100], 51, 6); 

Lfdobj = int2Lfd(4); 
smoothing_parameter = 1e-15;
forcefdPar = fdPar(forcebasis, Lfdobj, smoothing_parameter);

Pin_Force_Bow_Female_fd = smooth_basis(time, Pin_Force_Bow_Female, forcefdPar);
Pin_Force_Bow_Male_fd = smooth_basis(time, Pin_Force_Bow_Male, forcefdPar);

% Functional T-Test (automatic result plotting)
tpermStr1 = tperm_fd(Pin_Force_Bow_Male_fd, Pin_Force_Bow_Female_fd, 184756, 0.05);
