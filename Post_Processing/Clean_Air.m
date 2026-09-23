% ADVC Results - Yawing Moment Decoupling & Bidirectional Authority
clear; clc; close all;

% =========================================================================
% FIGURE 1: Yawing Moment Authority & Force Decoupling (Clean Air)
% =========================================================================

data=readmatrix("final_data.csv");

center_l=0.6;  %fixed_center_length
dih_l=0.45;    %dihedral_section_length
gap=0.02;

U_inf=40;   %m/s
rho=1.225;  %kg/m^3
q_inf=0.5*rho*(U_inf)^2;

c=0.3;       % chord length
b_ref= center_l + (2*dih_l)+(2*gap);   %Reference_span
S_ref=  c*(b_ref-(2*gap));               %Reference_Area
r_cg=1.5;    % moment arm (m)

flap_angles=data(8:10,2);
flap_angles(4,1)=data(17,2);

mag_dC_My_raw=data(8:10,9);     % Total_Yaw
mag_dC_My_raw(4,1)=data(17,9);      %Total_Yaw

side_force= data(8:10,8);
side_force(4,1)=data(17,8);

side_moment=r_cg*side_force;    %side_force_yaw_contribution

mag_dC_My=abs(mag_dC_My_raw/(b_ref*q_inf*S_ref));   % total_moment_nondim


dC_side= abs(side_moment/(b_ref*q_inf*S_ref));  %side_moment_nondim



fig1 = figure('Name', 'Force Decoupling', 'Position', [100, 100, 700, 500]);
set(fig1, 'Color', 'w');

% Plot Total Yawing Moment
plot(flap_angles, mag_dC_My, '-ko', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'k');
hold on;
% Plot Side Force Contribution
plot(flap_angles, dC_side, '--r^', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

xlabel('Dihedral Flap Angle, $\delta_L$ ($^\circ$)', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Coefficient Magnitude ($|\Delta C_{M_y}|, |\Delta C_{M_y, F_z}|$)', 'Interpreter', 'latex', 'FontSize', 14);
title('Yawing Moment Authority \& Force Decoupling ($0^\circ$ Slip)', 'Interpreter', 'latex', 'FontSize', 16);

xlim([0, 15]);
ylim([0, 0.025]);
xticks([0, 5, 10, 15]);
grid on;

legend('Total Fluent Yaw Moment ($|\Delta C_{M_y}|$)', ...
       'Estimated Side Force Moment Contribution, x=1.5 ($|\Delta C_{M_y, F_z}|$)', ...
       'Location', 'northwest', 'Interpreter', 'latex', 'FontSize', 12, 'EdgeColor', 'k');

ax1 = gca;
ax1.TickLabelInterpreter = 'latex';

% =========================================================================
% FIGURE 2: Bidirectional Control Envelope (Crossflow)
% =========================================================================
beta_angles = [0, 2.5, 5.0];   %slip_angle


left_flap_tot=data(17:18,9);    % total_yaw_15_degree_deployment
left_flap_tot(3,1)=data(20,9);  % total_yaw_15_degree_deployment

baseline_yaw=data(8,9);     %baseline_yaw_under_crossflow_no_deployment
baseline_yaw(2,1)=data(11,9);
baseline_yaw(3,1)= data(14,9);

delta_yaw_l= left_flap_tot-baseline_yaw;   % Raw_moment_coneribution
dC_My_left=(delta_yaw_l/(b_ref*q_inf*S_ref)).'; %Delta_yaw_nondim

right_flap_tot=abs(data(17,9));    % total_yaw_15_degree_deployment
right_flap_tot(2,1)=data(19,9);  % total_yaw_15_degree_deployment
right_flap_tot(3,1)=data(21,9);  % total_yaw_15_degree_deployment

delta_yaw_r=right_flap_tot-baseline_yaw;
dC_My_right=(delta_yaw_r/(b_ref*q_inf*S_ref)).';




fig2 = figure('Name', 'Bidirectional Authority Envelope', 'Position', [150, 150, 700, 500]);
set(fig2, 'Color', 'w');

% Plot boundaries
p1 = plot(beta_angles, dC_My_left, '-^', 'LineWidth', 2.5, 'MarkerSize', 8, 'Color', '#0072BD', 'MarkerFaceColor', '#0072BD');
hold on;
p2 = plot(beta_angles, dC_My_right, '-v', 'LineWidth', 2.5, 'MarkerSize', 8, 'Color', '#D95319', 'MarkerFaceColor', '#D95319');

% Shaded control envelope
patch([beta_angles, fliplr(beta_angles)], [dC_My_left, fliplr(dC_My_right)], ...
      [0.8 0.8 0.8], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

xlabel('Inlet Slip Angle, $\beta$ ($^\circ$)', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\Delta$ Yaw Moment Coefficient ($|\Delta C_{M_y}|$)', 'Interpreter', 'latex', 'FontSize', 14);
title('Bidirectional Control Envelope Under Crossflow', 'Interpreter', 'latex', 'FontSize', 16);

xlim([0, 5]);
ylim([-0.03, 0.03]);
grid on;

legend([p1, p2], {'Left Flap Max Deployment ($15^\circ$)', 'Right Flap Max Deployment ($15^\circ$)'}, ...
       'Location', 'northeast', 'Interpreter', 'latex', 'FontSize', 12);

ax2 = gca;
ax2.TickLabelInterpreter = 'latex';
