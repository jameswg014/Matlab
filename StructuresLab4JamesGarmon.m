% Structures Lab 4
% James Garmon
clear;clc; close all;
% Import Data from Excel
ShearData = readcell("Shear_Center_Data.xlsx");
OffShearData = readcell("Off_Shear_Center_Data.xlsx");
% Extract relevant data (Tube dimensions, Gage locations, Load, etc.)
RodDiameter = cell2mat(ShearData(2:end,1));
RodDiameter = RodDiameter(1,1);  % Tube Outer Diameter [in]
SheetThickness = cell2mat(ShearData(2:end,2));
SheetThickness = SheetThickness(1,1);  % Tube Thickness [in]
SheetLength = cell2mat(ShearData(2:end,3));
SheetLength = SheetLength(1,1);  % Tube Length [in]
GageLoc = cell2mat(ShearData(2:end,4));
GageLoc = GageLoc(1,1);  % Gage Location from Root [in]
LoadLocation = cell2mat(ShearData(2:end,5));
LoadLocation = LoadLocation(1,1);  % Arm Length [in]
Load = cell2mat(ShearData(2:end,6)) ./ 4.448;  % Load [N -> lbf]
% Center Shear Data
Gage1Center = cell2mat(OffShearData(2:end,7)); 
Gage2Center = cell2mat(OffShearData(2:end,8)); 
Gage3Center = cell2mat(OffShearData(2:end,9)); 
Gage4Center = cell2mat(OffShearData(2:end,10)); 
Gage5Center = cell2mat(OffShearData(2:end,11)); 
Gage6Center = cell2mat(OffShearData(2:end,12)); 
Gage7Center = cell2mat(OffShearData(2:end,13)); 
% Off center Shear Data
Gage1OffCenter = cell2mat(OffShearData(2:end,7)); 
Gage2OffCenter = cell2mat(OffShearData(2:end,8)); 
Gage3OffCenter = cell2mat(OffShearData(2:end,9)); 
Gage4OffCenter = cell2mat(OffShearData(2:end,10)); 
Gage5OffCenter = cell2mat(OffShearData(2:end,11)); 
Gage6OffCenter = cell2mat(OffShearData(2:end,12)); 
Gage7OffCenter = cell2mat(OffShearData(2:end,13)); 
% Material properties
E = 10000000; % [psi]
G = 3800000;  % [psi]
v = 0.33;     % Poisson's Ratio
% Plot load vs. strain for each gage for off center shear data
figure;
plot(Gage1Center, Load, 'o-', 'DisplayName', 'Gage 1', 'LineWidth', 1.5); hold on;
plot(Gage2Center, Load, 's-', 'DisplayName', 'Gage 2', 'LineWidth', 1.5);
plot(Gage3Center, Load, 'd-', 'DisplayName', 'Gage 3', 'LineWidth', 1.5);
plot(Gage4Center, Load, '^-', 'DisplayName', 'Gage 4', 'LineWidth', 1.5);
plot(Gage5Center, Load, 'x-', 'DisplayName', 'Gage 5', 'LineWidth', 1.5);
plot(Gage6Center, Load, 'v-', 'DisplayName', 'Gage 6', 'LineWidth', 1.5);
plot(Gage7Center, Load, 'p-', 'DisplayName', 'Gage 7', 'LineWidth', 1.5);
xlabel('Strain');
ylabel('Load (lbf)');
title('Load vs. Strain Readings (Off Center)');
legend show; grid on; hold off;
% Plot load vs. strain for each gage for shear Off Center data
figure;
plot(Gage1OffCenter, Load, 'o-', 'DisplayName', 'Gage 1', 'LineWidth', 1.5); hold on;
plot(Gage2OffCenter, Load, 's-', 'DisplayName', 'Gage 2', 'LineWidth', 1.5);
plot(Gage3OffCenter, Load, 'd-', 'DisplayName', 'Gage 3', 'LineWidth', 1.5);
plot(Gage4OffCenter, Load, '^-', 'DisplayName', 'Gage 4', 'LineWidth', 1.5);
plot(Gage5OffCenter, Load, 'x-', 'DisplayName', 'Gage 5', 'LineWidth', 1.5);
plot(Gage6OffCenter, Load, 'v-', 'DisplayName', 'Gage 6', 'LineWidth', 1.5);
plot(Gage7OffCenter, Load, 'p-', 'DisplayName', 'Gage 7', 'LineWidth', 1.5);
xlabel('Strain');
ylabel('Load (lbf)');
title('Load vs. Strain Readings (Shear Center)');
legend show; grid on; hold off;

% % % Convert strain data from microstrain to strain (Center Shear Data)
% % Gage1Center = cell2mat(ShearData(2:end,7)) * 1e-6; 
% % Gage2Center = cell2mat(ShearData(2:end,8)) * 1e-6; 
% % Gage3Center = cell2mat(ShearData(2:end,9)) * 1e-6; 
% % Gage4Center = cell2mat(ShearData(2:end,10)) * 1e-6; 
% % Gage5Center = cell2mat(ShearData(2:end,11)) * 1e-6; 
% % Gage6Center = cell2mat(ShearData(2:end,12)) * 1e-6; 
% % Gage7Center = cell2mat(ShearData(2:end,13)) * 1e-6;
% % % Convert strain data from microstrain to strain (Off Center Shear Data)
% % Gage1OffCenter = cell2mat(OffShearData(2:end,7)) * 1e-6; 
% % Gage2OffCenter = cell2mat(OffShearData(2:end,8)) * 1e-6; 
% % Gage3OffCenter = cell2mat(OffShearData(2:end,9)) * 1e-6; 
% % Gage4OffCenter = cell2mat(OffShearData(2:end,10)) * 1e-6; 
% % Gage5OffCenter = cell2mat(OffShearData(2:end,11)) * 1e-6; 
% % Gage6OffCenter = cell2mat(OffShearData(2:end,12)) * 1e-6; 
% % Gage7OffCenter = cell2mat(OffShearData(2:end,13)) * 1e-6; 

% Calculate theoretical shear strain
J = (pi / 32) * (RodDiameter^4 - (RodDiameter - 2 * SheetThickness)^4);  % Polar moment of inertia
T = Load .* LoadLocation;  % Torque
tau_theoretical = (T .* 2) ./ (RodDiameter .* J);  % Theoretical shear stress
% Calculate shear stress from strain gage rosette
gamma_xy1 = Gage3Center - Gage1Center;
tau_rossette1 = gamma_xy1 .* G;
gamma_xy2 = Gage7Center - Gage5Center;
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
theta = (T .* SheetLength) ./ (G .* J) * (180 / pi);  % Angle of twist [degrees]
% Plot angle of twist vs. load
figure; hold on;
plot(theta, Load, 'o-', 'DisplayName', 'Angle of Twist', 'LineWidth', 1);
xlabel('Angle of Twist (Degrees)');
ylabel('Load (lbf)');
title('Angle of Twist vs. Load');
legend show; grid on; hold off;

