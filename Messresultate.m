% Laborversuch Mechatronik
% Motor Ausmessen

v2hz = @(v) v/14.3*1000/60;
rpm2v = @(rpm) rpm/1000*14.3;

%% Aufgabe 1
% Widerstand variiert je nach Rotorstellung:

r1 = mean([3.3 2.7 3.0 3.6])
r2 = mean([2.4 2.7 2.9 3.2])

%% Aufgabe 4
% Uq = c*phi"n  -->  c*phi = Uq/n
% Speisespannung: je 10V


Uq1 = 8.61;
Uq2 = 8.63;
n1 = v2hz(13.13);
n2 = v2hz(13.15);

% Resultat:
c_phi1 = Uq2/n2
c_phi2 = Uq2/n2

%% Aufgabe 5
% Soll Umdrehungen: 1800rpm und 900rpm
Un_soll_900 = rpm2v(900);
Un_soll_1800 = rpm2v(1800);

Motor2_1800rpm = xlsread('Messresultate.xlsx', 'Tabelle1', 'B3:F11');
P_Motor2_1800rpm = polyfit(Motor2_1800rpm(3:end,4), Motor2_1800rpm(3:end,5), 1);
r2_1800rpm = -P_Motor2_1800rpm(1)
ub_r2_1800rpm = (Motor2_1800rpm(1,3) - P_Motor2_1800rpm(2))/2

Motor2_900rpm = xlsread('Messresultate.xlsx', 'Tabelle1', 'B13:F18');
P_Motor2_900rpm = polyfit(Motor2_900rpm(3:end,4), Motor2_900rpm(3:end,5), 1);
r2_900rpm = -P_Motor2_900rpm(1)
ub_r2_900rpm = (Motor2_900rpm(1,3) - P_Motor2_900rpm(2))/2

Motor1_1800rpm = xlsread('Messresultate.xlsx', 'Tabelle1', 'B25:F31');
P_Motor1_1800rpm = polyfit(Motor1_1800rpm(3:end,2), Motor1_1800rpm(3:end,3), 1);
r1_1800rpm = -P_Motor1_1800rpm(1)
ub_r1_1800rpm = (Motor1_1800rpm(1,3) - P_Motor1_1800rpm(2))/2

Motor1_900rpm = xlsread('Messresultate.xlsx', 'Tabelle1', 'B34:F38');
P_Motor1_900rpm = polyfit(Motor1_900rpm(3:end,2), Motor1_900rpm(3:end,3), 1);
r1_900rpm = -P_Motor1_900rpm(1)
ub_r1_900rpm = (Motor1_900rpm(1,3) - P_Motor1_900rpm(2))/2


%% Aufgabe 7
% Soll Speisespannungen: 20V und 40V
Motor1_20V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B3:F9');
Motor1_40V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B12:F16');
Motor2_20V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B23:F27');
Motor2_40V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B30:F34');

%% Aufgabe 8
% Soll Speisespannung: 40V (mit Vorwiderstand)
Motor1_40V_10Ohm= xlsread('Messresultate.xlsx', 'Tabelle3', 'B3:F8');
Motor2_40V_10Ohm = xlsread('Messresultate.xlsx', 'Tabelle3', 'B16:F20');

%% Aufgabe 9
r1_warm = mean([2.6 2.4 2.4 2.5])
r2_warm = mean([2.3 2.2 2.5])