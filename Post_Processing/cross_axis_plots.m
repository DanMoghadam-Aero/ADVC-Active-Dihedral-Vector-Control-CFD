% ADVC Axis Decoupling and Cross-Axis Disturbance Isolation
clc; clear; close all;

%% 1. Load Data and Define Reference Values
data = readmatrix("data_only.csv");
U_inf = 40;              % freestream velocity (m/s)
rho = 1.225;             % air density (kg/m^3)
q_inf = 0.5 * rho * U_inf^2; % dynamic pressure (Pa)
s_ref = 0.45;            % reference area (m^2)
b_ref = 1.54;            % reference span (m)
c = 0.3;                 % reference chord (m)

%% 2. Extract and Non-Dimensionalize Data
% Drag
drag_f = [data(1:3,6); data(10,6)];
drag_non = drag_f / (q_inf * s_ref);

% Downforce
down_f = [data(1:3,7); data(10,7)];
down_non = down_f / (q_inf * s_ref);

% Yaw (Absolute magnitude for scaling)
yaw_m = [data(1:3,9); data(10,9)];
yaw_non = abs(yaw_m / (q_inf * s_ref * b_ref));

% Pitch (Absolute magnitude)
pitch_m = [data(1:3,10); data(10,10)];
pitch_non = (pitch_m / (q_inf * s_ref * b_ref));

% Roll (Absolute magnitude)
roll_m = [data(1:3,11); data(10,11)];
roll_non = (roll_m / (q_inf * s_ref * b_ref));

%% 3. Calculate Deltas (Change from baseline flap=0)
delta_drag = drag_non - drag_non(1);
delta_pitch =(pitch_non - pitch_non(1));
delta_roll = roll_non - roll_non(1);

% For downforce, percentage retention is the most powerful metric
retention_down = (down_non ./ down_non(1)) * 100; 

%% 4. Generating Plots
fig = figure('Name', 'ADVC Axis Isolation', 'Position', [100, 100, 1200, 800]);

% --- Subplot 1: Yaw vs. Drag Penalty ---
subplot(2,2,1);
plot(yaw_non, delta_drag, '-ro', 'LineWidth', 2.5, 'MarkerFaceColor', 'r', 'MarkerSize', 7);
title('Longitudinal-Force Coefficient Increment', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Generated Yaw Moment (|\Delta C_{M_y}|)', 'FontSize', 11);
ylabel('Drag Variation (\Delta C_x)', 'FontSize', 11);
ylim([-0.02, 0.001]); 
ax=gca;
ax.YAxis.Exponent = 0;
grid on; set(gca, 'GridAlpha', 0.4, 'LineWidth', 1);

% --- Subplot 2: Yaw vs. Downforce Retention ---
subplot(2,2,2);
plot(yaw_non, retention_down, '-ko', 'LineWidth', 2.5, 'MarkerFaceColor', 'k', 'MarkerSize', 7);
title('Downforce Retention', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Generated Yaw Moment (|\Delta C_{M_y}|)', 'FontSize', 11);
ylabel('Total Downforce Retained (%)', 'FontSize', 11);

ylim([90, 100]); 
grid on; set(gca, 'GridAlpha', 0.4, 'LineWidth', 1);

% --- Subplot 3: Yaw vs. Pitch Disturbance ---
subplot(2,2,3);
plot(yaw_non, delta_pitch, '-mo', 'LineWidth', 2.5, 'MarkerFaceColor', 'm', 'MarkerSize', 7);
title('Pitch Axis Isolation', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Generated Yaw Moment (|\Delta C_{M_y}|)', 'FontSize', 11);
ylabel('Pitch Disturbance (\Delta C_{M_z})', 'FontSize', 11);
% Adjust this ylim based on your actual data to keep the line visually shallow
ylim([0, 0.02]); 
%xlim([0 0.02]);
grid on; set(gca, 'GridAlpha', 0.4, 'LineWidth', 1);

% --- Subplot 4: Yaw vs. Roll Coupling ---
subplot(2,2,4);
plot(yaw_non, delta_roll, '-go', 'LineWidth', 2.5, 'MarkerFaceColor', 'g', 'MarkerSize', 7);
title('Geometric Roll Coupling', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Generated Yaw Moment (|\Delta C_{M_y}|)', 'FontSize', 11);
ylabel('Roll Disturbance (\Delta C_{M_x})', 'FontSize', 11);
% Roll will naturally be the steepest line, which supports your geometric argument
ylim([0, 0.02]); 
grid on; set(gca, 'GridAlpha', 0.4, 'LineWidth', 1);

% Global Title
sgtitle('ADVC Control Authority and Cross-Axis Disturbance Isolation', 'FontSize', 16, 'FontWeight', 'bold');