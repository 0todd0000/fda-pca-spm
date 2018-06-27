%% Load sample data

% Data for this World Congress of Biomechanics (WCB) 2018 workshop was 
% taken from:

% Warmenhoven, J. S., Harrison, A., Robinson, M., Vanrenterghem, J., 
% Bargary, N., Smith, R., Cobley, S., Draper, C., Donnelly, C., & Pataky,
% T. (2017). A force profile analysis comparison between functional data 
% analysis, statistical parametric mapping and statistical non-parametric 
% mapping in on-water single sculling. Journal of Science & Medicine in 
% Sport, In Press.

% For any questions related to this workshop (and script), please email
% john.warmenhoven@hotmail.com.

% The data can be loaded below and for the purposes of this exemplar 
% script, has been labelled "Simulated_Data."

load('Simulated_Data');

% This loads four seperate matrices which will be compared using Functional
% Data Analysis (FDA) techniques, Statistical Parametric and 
% Non-Parametric Mapping (SPM & SnPM) techniques and Principal Components 
% Analysis when it is applied to waveform data. 

% 1. 'Pin_Force_Bow_Male' is male data for the bow-side (left hand) and is
% ten curves in total.
% 2. 'Pin_Force_Bow_Female' is female data for the bow-side (left hand) and
% is ten curves in total.
% 3. 'Pin_Force_Stroke_Male' is male data for the stroke-side (right hand) 
% and is ten curves in total.
% 4. 'Pin_Force_Stroke_Female' is female data for the stroke-side (right 
% hand) and is ten curves in total.

% In each case these techniques will explore gender differences that exist
% in the characteristics of these profiles. 

%% Principal Components Analysis (PCA) of Waveforms

% To demonstrate how PCA can be applied to this data we will focus on the
% bow-side forces. The male and female data are combined into a single
% matrix to create a bow-side data set.

Bow_Side_Data = [Pin_Force_Bow_Male Pin_Force_Bow_Female]';

% The forces have been normalised to 51 data points using an interpolating
% cublic spline. Here they are centered within the time interval (which in 
% this case after temporal normalization is percentage of the stroke
% cycle).

time = linspace(0, 100, 51)'; 

% The 'pca' function is an inbuilt Matlab function and can be applied to
% waveform data as a means of dimension reduction. This function returns
% co-efficients (x), which are principal components (PC), PC scores (y), 
% eigenvalues (z) of the covariance matrix of 'Bow_Side_Data,' Hotelling's 
% T-squared statistic for each observation (ii), and the percentage of the
% total variation attributed to each PC (iii). 

[x,y,z,ii,iii] = pca(Bow_Side_Data);

% The principal components themselves are time-series and can be observed 
% graphically. See the figures below. figure(105) shows PC1 and figure(106)
% shows PC2. 

figure(105)
plot(x(:,1));

figure(106)
plot(x(:,2));

% The PCs can also be observed from a more practical perspective by adding
% and substracting them from the average/mean curve. To do this, first the
% mean curve is calculated:

mean_curve = mean(Bow_Side_Data);

% Then a constant is created to scale each of the PCs before adding and
% substracting them from the mean. A constant that is commonly used is 1 or
% 2 standard deviations (SD) of the PC scores. So first the SD of PC scores
% is calculated for each PC. 

stdevscores = std(y);

% Then this is used to create the constant:

con1 = stdevscores(1)*1;

% And then scaled PCs are added and subtracted from the mean curve, before
% being plotted with the mean curve. 

PC1_Pos = mean_curve' + con1.*(x(:,1));
PC1_Neg = mean_curve' - con1.*(x(:,1));

% Figure(107) shows PC1, with positive scorers plotted using the '+'
% symbols and negative scorers plotted using the '-' symbols. 

figure(107)
phdl = plot(time, mean_curve', 'k-');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = text(time, PC1_Pos, '+');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = text(time, PC1_Neg, '-');
set(phdl, 'LineWidth', 1.5)
hold off
box on
set(gca,'FontSize',10);
title('\fontsize{10} PC1');
xlabel('\fontsize{10} Drive Phase (%)')
ylabel('\fontsize{10} Force (N)')
axis([0,100,-100,700])

% The same process is also carried out for PC2. Inclusive of creating a
% constant to scale the PCs.

con2 = stdevscores(2)*1;

PC2_Pos = mean_curve' + con2.*(x(:,2));
PC2_Neg = mean_curve' - con2.*(x(:,2));

figure(108)
phdl = plot(time, mean_curve', 'k-');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = text(time, PC2_Pos, '+');
set(phdl, 'LineWidth', 1.5)
hold on
phdl = text(time, PC2_Neg, '-');
set(phdl, 'LineWidth', 1.5)
hold off
box on
set(gca,'FontSize',10);
title('\fontsize{10} PC2');
xlabel('\fontsize{10} Drive Phase (%)')
ylabel('\fontsize{10} Force (N)')
axis([0,100,-100,700])

% An example of a way to graph the principal component scores can also be 
% seen below, with males in blue and females in red for PC1 and PC2. 

figure(109)
scatter(y(1:10,1),y(1:10,2), 'b');
hold on
scatter(y(11:20,1),y(11:20,2), 'r');
hold off
box on
set(gca,'FontSize',10);
title('\fontsize{10} PC1 vs PC2');
xlabel('\fontsize{10} PC1 Scores')
ylabel('\fontsize{10} PC2 Scores')
axis([-1000,1000,-400,400])