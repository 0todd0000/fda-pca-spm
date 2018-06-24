

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

%% Add file paths

% The files for using FDA, SPM and SnPM can be obtained from the 
% software/download sections of the www.functionaldata.org and 
% www.spm1d.org websites. The software packages for Matlab are available 
% and can be downloaded to a convenient location on your computer. The 
% paths of these Matlab functions will need to be added before using these 
% techniques. Make sure to name the filepath correctly (see below):

addpath('E:\1. WCB Workshop\fdaM\')
addpath('E:\1. WCB Workshop\spm1dmatlab-master\')
addpath('E:\1. WCB Workshop\spm1dmatlab-master\spm8')

%% Functional Data Analysis (Preliminary Steps)

% FDA involves a series of preliminary steps prior to applying any 
% techniques. These are mainly centred around function fitting, smoothing 
% processes and registration of data.

% An example of function fitting and smoothing is included in this script,
% but registration was not necessary for this data set so was not included.

% The forces have been normalised to 51 data points using an interpolating
% cublic spline. Here they are centered within the time interval (which in 
% this case after temporal normalization is percentage of the stroke
% cycle).

time = linspace(0, 100, 51)'; 

% The next step involves estimation of functions using a suitable basis 
% expansion. FDA has options for a number of different basis expansions 
% (Fourier, B-splines, Wavelets, etc.). In this instance the functions 
% were fitted using B-splines as the data was truncated after the drive 
% phase (propulsive phase of the movement), and as a consequence were no 
% longer best represented by Fourier functions (which work best for
% periodic data).

% **Ask Norma more about describing this, paricularly how and why you 
% select the number of knots and number of functions (i.e. 6 and 51).**

forcebasis = create_bspline_basis([0,100], 51, 6); 

% Here we set up the penalty for roughness by defining a linear
% differential operator object. In this instance we have selected smoothing
% to be achieved by penalizing the squared curvature of the second
% derivative. Despite this smoothing should not possess any substantial
% effect on the data as it was already smoothed using a low-pass
% Butterowrth filter with a 6Hz cut-off Frequency. This will be discussed
% further.

% **Ask Norma more about describing this, particuarly with reference to the
% 'int2Lfd' fucntion and the four different ways that data can be
% smoothed.**

Lfdobj = int2Lfd(4); 

% Now we set up a functional parameter object to define the amount of 
% smoothing. As mentioned above, smoothing should not possess any effect
% on this data set due to filtering that was already applied as a part of
% data pre-processing. A smoothing parameter is nominated to account for 
% the magnitude of smoothing. Unfortunately the FDA Matlab software at 
% present does not allow for the selection of a '0' smoothing parameter,
% and thus a parameter of 1e-15 was selected due to it having minimal
% effect on changes to the characteristics of the data set. 

% The smoothing parameter will often be selected using a process of visual
% inspection of the fitting process using the 'plotfit_fd' function or by
% using processes such as generalized cross-validation. 

smoothing_parameter = 1e-15;

forcefdPar = fdPar(forcebasis, Lfdobj, smoothing_parameter);

% Once smoothing details are finalized, they can be combined with the type
% of expansion process to fit each of the groups of curves using the
% 'smooth_basis' function. 

%% Functional Principal Components Analysis (fPCA)

% In the functional t-test we described the male and female groups as
% seperate functional data objects. In fPCA we describe all curves as the
% same functional data object using the 'smooth_basis' function. 

Pin_Force_Bow_fd = smooth_basis(time, [Pin_Force_Bow_Male Pin_Force_Bow_Female], forcefdPar);

% We have also listed the number of functional principal components to be
% retained as five.

nharm  = 5;

% Similar to the function fitting and smoothing processes described in the
% FDA (Preliminary Steps) section, it is also possible to smooth fPC
% functions as a part of describing them. Again the same negligible
% smoothing parameter was selected. 

Pin_Force_Bow_pcastr = pca_fd(Pin_Force_Bow_fd, nharm, forcefdPar);

% The FDA software package for Matlab has a function that is designed
% specifically for visualization of fPCs. 'plot_pca_fd' has a number of
% options (explained within the Matlab) function for how you can modify the
% visual display of these fPCs. 

plot_pca_fd(Pin_Force_Bow_pcastr, 0, 1, 0, 0, 0);

% If researchers wish to have more control over graphing of the fPCs
% (similar to the example provided for conventional PCA), relevant parts of
% the FDA and fPCA processes can be extracted and then called upon for
% plotting. Most of these will come from a 'struct' that has been built
% as a part of the 'pca_fd' function. In this case the struct is called
% "Pin_Force_Bow_pcastr."

% As an example the mean function (as a functional data object) can be 
% called on as:

Forcemeanfd = mean(Pin_Force_Bow_fd);

% Similarly, the fPC functions (as functional data objects) can be called
% upon using:

Forceharmfd  = Pin_Force_Bow_pcastr.harmfd;

% We can also unwrap the mean function and fPC functions to a vector of
% points that can be used for graphical observatiuon and plotting of 
% results:

Forcemeanvec = squeeze(eval_fd((time), Forcemeanfd));
Forceharmmat = eval_fd(time, Forceharmfd);

% We can also identify the amount of variation attributed to each fPC by 
% exploring the 'varprop' part of the struct. 

Forcevarprop = Pin_Force_Bow_pcastr.varprop;

% And also derive the weights attributed to each of the individual curves
% relative to each fPC. These are also referred to as fPC scores (similar
% to PC scores in the previous example). 

Forcescores = Pin_Force_Bow_pcastr.harmscr; 

% Similar to PCA, a constant is created to scale each fPC before adding and
% substracting them from the mean. A constant that is commonly used is 1 or
% 2 SDs of the fPC scores. So first the SD of fPC scores is calculated for 
% each PC. 

stdevfPCscores = std(Forcescores);

% After this 1 SD is used to create the constant:

con1 = stdevfPCscores(1)*1;

% And then scaled fPCs are added and subtracted from the mean curve, before
% being plotted with the mean curve. 

fPC1_Pos = Forcemeanvec + con1.*(Forceharmmat(:,1));
fPC1_Neg = Forcemeanvec - con1.*(Forceharmmat(:,1));

% Figure(110) shows fPC1, with positive scorers plotted using the '+'
% symbols and negative scorers plotted using the '-' symbols.

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

% The same process is also carried out for fPC2. Inclusive of creating a
% constant to scale the fPCs.

con2 = stdevfPCscores(2)*1;

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

% Again, similar to PCA, an example of a way to graph fPC scores can be 
% seen below, with males in blue and females in red for fPC1 and fPC2. 

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


