%% Out-of-the-box 3-shell head conduction model
%load('fieldtrip-20141231/template/headmodel/standard_bem.mat') % loaded only for visualization

%% Default HydroCel Geodesic electrodes
elec = ft_read_sens('HydroCel256/HCGSN257.xyz','fileformat','besa_sfp');
% convert unit to mm
elec = ft_convert_units(elec, 'mm');

%% Visualize
%figure('color','k');;
%ft_plot_sens(elec,'style','.g');
%ft_plot_mesh(vol.bnd(1), 'edgecolor','none','facealpha',0.4,'facecolor',[0.6 0.6 0.8]);
%title 'BEFORE ALIGNMENT' 'color' 'w'


%% Standard 10-20 electrodes, already aligned to the head model
elec1020 = ft_read_sens('fieldtrip-20141231/template/electrode/standard_1020.elc');
% convert unit to mm
elec1020 = ft_convert_units(elec1020, 'mm');

%% Align HydroCel electrodes
% homogeneous transformation matrices, that bring electrodes to common coordinates
elec2common = ft_headcoordinates(elec.chanpos(1,:), elec.chanpos(2,:), elec.chanpos(3,:));
ref2common = ft_headcoordinates(elec1020.chanpos(3,:), elec1020.chanpos(1,:), elec1020.chanpos(2,:));
% scaling factors
nz_lpa_cz_elec2common = ft_warp_apply(elec2common, elec.chanpos([1 2 260],:), 'homogeneous');
nz_lpa_cz_ref2common = ft_warp_apply(ref2common, elec1020.chanpos([3 1 45],:), 'homogeneous');
xyzscale = sqrt(sum(nz_lpa_cz_ref2common.^2,2) ./ sum(nz_lpa_cz_elec2common.^2,2));
% calibrate electrodes
chanpos_elec2common = ft_warp_apply(elec2common, elec.chanpos(4:end,:), 'homogeneous') * diag(xyzscale);
elec.chanpos = ft_warp_apply(inv(ref2common), chanpos_elec2common, 'homogeneous');
elec.elecpos = elec.chanpos;
elec.label = elec.label(4:end);
elec.type = 'eeg';

%% Visualize
%figure('color','k');
%ft_plot_sens(elec,'style','.g');
%ft_plot_mesh(vol.bnd(1), 'edgecolor','none','facealpha',0.4,'facecolor',[0.6 0.6 0.8]);
%title 'AFTER ALIGNMENT' 'color' 'w'
