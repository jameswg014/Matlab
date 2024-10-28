% Structures Lab 3
% James Garmon
clear;clc; close all;
% Import Data from Excel
Data = readcell("Lab3_data.xlsx");
% Extract relevant data (Tube dimensions, Gage locations, Load, etc.)
TubeOuterD = cell2mat(Data(2:end,1));
TubeOuterD = TubeOuterD(1,1);  % Tube Outer Diameter [in]
TubeThickness = cell2mat(Data(2:end,2));
TubeThickness = TubeThickness(1,1);  % Tube Thickness [in]
TubeLength = cell2mat(Data(2:end,3));
TubeLength = TubeLength(1,1);  % Tube Length [in]
GageLoc = cell2mat(Data(2:end,4));
GageLoc = GageLoc(1,1);  % Gage Location from Root [in]
Arm = cell2mat(Data(2:end,5));
Arm = Arm(1,1);  % Arm Length [in]
Load = cell2mat(Data(2:end,6)) ./ 4.448;  % Load [N -> lbf]
% Convert strain data from microstrain to strain
Gage1 = cell2mat(Data(2:end,7)) * 1e-6; 
Gage2 = cell2mat(Data(2:end,8)) * 1e-6; 
Gage3 = cell2mat(Data(2:end,9)) * 1e-6; 
Gage4 = cell2mat(Data(2:end,10)) * 1e-6; 
Gage5 = cell2mat(Data(2:end,11)) * 1e-6; 
Gage6 = cell2mat(Data(2:end,12)) * 1e-6; 
Gage7 = cell2mat(Data(2:end,13)) * 1e-6; 
% Material properties
E = 10000000; % [psi]
G = 3800000;  % [psi]
v = 0.33;     % Poisson's Ratio
% Plot load vs. strain for each gage
figure;
plot(Gage1, Load, 'o-', 'DisplayName', 'Gage 1', 'LineWidth', 1.5); hold on;
plot(Gage2, Load, 's-', 'DisplayName', 'Gage 2', 'LineWidth', 1.5);
plot(Gage3, Load, 'd-', 'DisplayName', 'Gage 3', 'LineWidth', 1.5);
plot(Gage4, Load, '^-', 'DisplayName', 'Gage 4', 'LineWidth', 1.5);
plot(Gage5, Load, 'x-', 'DisplayName', 'Gage 5', 'LineWidth', 1.5);
plot(Gage6, Load, 'v-', 'DisplayName', 'Gage 6', 'LineWidth', 1.5);
plot(Gage7, Load, 'p-', 'DisplayName', 'Gage 7', 'LineWidth', 1.5);
xlabel('Strain');
ylabel('Load (lbf)');
title('Load vs. Strain Readings');
legend show; grid on; hold off;
% Calculate theoretical shear stress
J = (pi / 32) * (TubeOuterD^4 - (TubeOuterD - 2 * TubeThickness)^4);  % Polar moment of inertia
T = Load .* Arm;  % Torque
tau_theoretical = (T .* 2) ./ (TubeOuterD .* J);  % Theoretical shear stress
% Calculate shear stress from strain gage rosette
gamma_xy1 = Gage3 - Gage1;
tau_rossette1 = gamma_xy1 .* G;
gamma_xy2 = Gage7 - Gage5;
tau_rossette2 = gamma_xy2 .* G;
% Plot shear stress vs. load (theoretical vs. measured)
figure; hold on;
plot(tau_theoretical, Load, 'o-', 'DisplayName', 'Theoretical Stress', 'LineWidth', 1);
plot(tau_rossette1, Load, 's-', 'DisplayName', 'Rossette 1 Stress', 'LineWidth', 1);
plot(tau_rossette2, Load, '^-', 'DisplayName', 'Rossette 2 Stress', 'LineWidth', 1);
xlabel('Shear Stress (psi)');
ylabel('Load (lbf)');
title('Shear Stress: Theoretical vs. Measured');
legend show; grid on; hold off;
% Calculate angle of twist
theta = (T .* TubeLength) ./ (G .* J) * (180 / pi);  % Angle of twist [degrees]
% Plot angle of twist vs. load
figure; hold on;
plot(theta, Load, 'o-', 'DisplayName', 'Angle of Twist', 'LineWidth', 1);
xlabel('Angle of Twist (Degrees)');
ylabel('Load (lbf)');
title('Angle of Twist vs. Load');
legend show; grid on; hold off;

