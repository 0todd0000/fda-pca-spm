
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

%% Descriptive Statistics

% Mean and standard deviation error clouds are useful as descriptive 
% statistics for inspection of differences between experimental groups.
% These can be plotted easily using the spm1d.org software:

% TODD TO PUT IN HERE

% 