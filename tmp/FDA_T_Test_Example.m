
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

Pin_Force_Bow_Female_fd = smooth_basis(time, Pin_Force_Bow_Female, forcefdPar);

Pin_Force_Bow_Male_fd = smooth_basis(time, Pin_Force_Bow_Male, forcefdPar);

%% Functional T-Test

% This is a permutation t-test for functional data, which was outlined in
% the FDA text "Functional Data Analysis for Matlab and R." The 'tperm_fd' 
% allows for execution of the functional t-test and the results of this
% statistical test will be explored in detail as a part of thw WCB workshop
% presentation.

tpermStr1 = tperm_fd(Pin_Force_Bow_Male_fd, Pin_Force_Bow_Female_fd, 184756, 0.05);

% For these tests, the number of permutations were set at the maximum
% (184756) and the alpha level was set to 0.05. 

% The t-test is for bow-side data is exploring gender differences.
