
% Principal Components Analysis (PCA)

%Script details and extended comments are provided in the "Notebooks" folder at:
%https://github.com/0todd0000/fda-pca-spm

clear; clc   %clear workspace
close all    %close all figures

load('Warmenhoven2018-bow-force.mat');

Y = [Pin_Force_Bow_Male Pin_Force_Bow_Female]';
t = linspace(0, 100, 51)'; %time


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