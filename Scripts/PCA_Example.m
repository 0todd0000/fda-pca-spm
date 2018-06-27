
% Principal Components Analysis (PCA)

%Script details and extended comments are provided in the "Notebooks" folder at:
%https://github.com/0todd0000/fda-pca-spm

clear; clc   %clear workspace
close all    %close all figures


%% load and combine data into a single array
load('Warmenhoven2018-bow-force.mat');
Y = [Pin_Force_Bow_Male Pin_Force_Bow_Female]';
t = linspace(0, 100, 51)';  %time


%% Run PCA
[coeff,score,latent,tsquared,explained] = pca(Y);



%% Visualize first two PCs
figure(1)
pc1 = coeff(:,1);
pc2 = coeff(:,2);
plot(t, pc1)
hold on
plot(t, pc2)
legend('PC-1', 'PC-2')


%% Visualize first PC in the context of the overall mean trajectory
figure(2)
ymean    = mean(Y, 1)';
scoresd  = std(score, [], 1)';
plot(t, ymean, 'k', 'linewidth', 3)
hold on
plot(t, ymean + scoresd(1) .* pc1, 'b+')
plot(t, ymean - scoresd(1) .* pc1, 'bv')
title('PC-1')


%% Visualize second PC in the context of the overall mean trajectory
figure(3)
plot(t, ymean, 'k', 'linewidth', 3)
hold on
plot(t, ymean + scoresd(2) .* pc2, 'b+')
plot(t, ymean - scoresd(2) .* pc2, 'bv')
title('PC-2')


%% Visualize first two PC scores
figure(4)
plot( score(1:10,1), score(1:10,2), 'bo' );
hold on
plot( score(11:20,1), score(11:20,2), 'ro' );
plot( score(11:20,1), score(11:20,2), 'ro' );
xlabel('PC-1')
ylabel('PC-2')
legend('males', 'females')
ax = gca();
plot([0 0], get(ax,'ylim'), 'k:')
plot(get(ax,'xlim'), [0 0], 'k:')