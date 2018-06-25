% Functional Data Analysis (fPCA)

%Script details and extended comments are provided in the "Notebooks" folder at:
%https://github.com/0todd0000/fda-pca-spm

clear; clc   %clear workspace
close all    %close all figures

load('Warmenhoven2018-bow-force');


% FDA (Preliminary Steps)

time       = linspace(0, 100, 51)'; 
forcebasis = create_bspline_basis([0,100], 51, 6); 

Lfdobj              = int2Lfd(4); 
smoothing_parameter = 1e-15;
forcefdPar          = fdPar(forcebasis, Lfdobj, smoothing_parameter);


% Functional Principal Components Analysis (fPCA)
Pin_Force_Bow_fd     = smooth_basis(time, [Pin_Force_Bow_Male Pin_Force_Bow_Female], forcefdPar);
nharm                = 5;
Pin_Force_Bow_pcastr = pca_fd(Pin_Force_Bow_fd, nharm, forcefdPar);
plot_pca_fd(Pin_Force_Bow_pcastr, 0, 1, 0, 0, 0);


Forcemeanfd    = mean(Pin_Force_Bow_fd);
Forceharmfd    = Pin_Force_Bow_pcastr.harmfd;

Forcemeanvec   = squeeze(eval_fd((time), Forcemeanfd));
Forceharmmat   = eval_fd(time, Forceharmfd);

Forcevarprop   = Pin_Force_Bow_pcastr.varprop;
Forcescores    = Pin_Force_Bow_pcastr.harmscr; 
stdevfPCscores = std(Forcescores);
con1           = stdevfPCscores(1)*1;

fPC1_Pos       = Forcemeanvec + con1.*(Forceharmmat(:,1));
fPC1_Neg       = Forcemeanvec - con1.*(Forceharmmat(:,1));


figure(110)
phdl = plot(time, Forcemeanvec, 'k-');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = text(time, fPC1_Pos, '+');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = text(time, fPC1_Neg, '-');
set(phdl, 'LineWidth', 1.5)
hold off
box on
set(gca,'FontSize',10);
title('\fontsize{10} fPC1');
xlabel('\fontsize{10} Drive Phase (%)')
ylabel('\fontsize{10} Force (N)')
axis([0,100,-100,700])



con2     = stdevfPCscores(2)*1;
fPC2_Pos = Forcemeanvec + con2.*(Forceharmmat(:,2));
fPC2_Neg = Forcemeanvec - con2.*(Forceharmmat(:,2));

figure(111)
phdl = plot(time, Forcemeanvec, 'k-');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = text(time, fPC2_Pos, '+');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = text(time, fPC2_Neg, '-');
set(phdl, 'LineWidth', 1.5)
hold off
box on
set(gca,'FontSize',10);
title('\fontsize{10} fPC2');
xlabel('\fontsize{10} Drive Phase (%)')
ylabel('\fontsize{10} Force (N)')
axis([0,100,-100,700])


figure(112)
phdl = scatter(Forcescores(1:10,1),Forcescores(1:10,2), 'b');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = scatter(Forcescores(11:20,1),Forcescores(11:20,2), 'r');
set(phdl, 'LineWidth', 1.5)
hold off
box on
set(gca,'FontSize',10);
title('\fontsize{10} fPC1 vs fPC2');
xlabel('\fontsize{10} fPC1 Scores')
ylabel('\fontsize{10} fPC2 Scores')
axis([-1000,1000,-400,400])


