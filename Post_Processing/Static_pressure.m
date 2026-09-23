% =========================================================================
% ADVC Flow Analysis: Chordwise Pressure Distribution (0 deg vs 15 deg)
% =========================================================================
clear; clc; close all;

% Fluent Data
data_0  = readmatrix('CP_0_deg.csv', 'NumHeaderLines', 5);
data_15 = readmatrix('Cp_15_deg.csv', 'NumHeaderLines', 5);

% Extract X-coordinates (Column 1) and Pressure (Column 2)
X_0  = data_0(:, 1);
P_0  = data_0(:, 2);

X_15 = data_15(:, 1);
P_15 = data_15(:, 2);


% Figure
figure('Name', 'ADVC Pressure Overlay', 'Color', 'w', 'Position', [100, 100, 800, 500]);
hold on; grid on;

% Plot the Data
plot(X_0, P_0, 'b.', 'MarkerSize', 12, 'DisplayName', '0^\circ Flap (Baseline)');
plot(X_15, P_15, 'r.', 'MarkerSize', 12, 'DisplayName', '15^\circ Flap Deployed');

% Axis_Formatting
xlabel('Chordwise Position, X [m]', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Static Pressure [Pa]', 'FontSize', 12, 'FontWeight', 'bold'); % Change to C_p if converted above
title('Outboard Chordwise Pressure Distribution Comparison', 'FontSize', 14);

% Legend
lgd = legend('Location', 'best', 'FontSize', 11);
lgd.ItemTokenSize = [15, 18];

% Clean up the grid aesthetics
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
box on;
hold off;