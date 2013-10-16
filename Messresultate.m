% Laborversuch Mechatronik
% Motor Ausmessen

v2hz = @(v) v/14.3*1000/60;
rpm2v = @(rpm) rpm/1000*14.3;

%% Aufgabe 1
% Widerstand variiert je nach Rotorstellung:
r1 = mean([3.3 2.7 3.0 3.6]);
r2 = mean([2.4 2.7 2.9 3.2]);

%% Aufgabe 4
% Uq = c*phi"n  -->  c*phi = Uq/n
% Speisespannung: je 10V

Uq1 = 8.61;
Uq2 = 8.63;
n1 = v2hz(13.13);
n2 = v2hz(13.15);

% Resultat:
c_phi1 = Uq2/n2;
c_phi2 = Uq2/n2;

%% Aufgabe 5
% Soll Umdrehungen: 1800rpm und 900rpm
Un_soll_900 = rpm2v(900);
Un_soll_1800 = rpm2v(1800);

%% Werte aus Excel einlesen
Motor2_1800rpm = xlsread('Messresultate.xlsx', 'Tabelle1', 'B3:F11');
Motor2_900rpm = xlsread('Messresultate.xlsx', 'Tabelle1', 'B13:F18');
Motor1_1800rpm = xlsread('Messresultate.xlsx', 'Tabelle1', 'B25:F31');
Motor1_900rpm = xlsread('Messresultate.xlsx', 'Tabelle1', 'B34:F38');

%% Berechnungen
% Generator: Motor 2 1800rpm
P_Motor2_1800rpm = polyfit(Motor2_1800rpm(3:end,4), Motor2_1800rpm(3:end,5), 1);
r2_1800rpm = -P_Motor2_1800rpm(1);
ub_r2_1800rpm = (Motor2_1800rpm(1,3) - P_Motor2_1800rpm(2))/2;

PelGen_1800M2G = Motor2_1800rpm(:,4).*Motor2_1800rpm(:,5);
PelMot_1800M2G = Motor2_1800rpm(:,2).*Motor2_1800rpm(:,3);
Mwelle_1800M2G = 0.5*c_phi1/(2*pi)*(Motor2_1800rpm(:,2)+Motor2_1800rpm(:,4));
Pwelle_1800M2G = 2*pi*Mwelle_1800M2G.*v2hz(Motor2_1800rpm(:,1));
etaGen_1800M2G = PelGen_1800M2G./Pwelle_1800M2G;
% Generator: Motor 2 900rpm

P_Motor2_900rpm = polyfit(Motor2_900rpm(3:end,4), Motor2_900rpm(3:end,5), 1);
r2_900rpm = -P_Motor2_900rpm(1);
ub_r2_900rpm = (Motor2_900rpm(1,3) - P_Motor2_900rpm(2))/2;

PelGen_900rpmM2 = Motor2_900rpm(:,4).*Motor2_900rpm(:,5);

% Generator: Motor 1 1800rpm

P_Motor1_1800rpm = polyfit(Motor1_1800rpm(3:end,2), Motor1_1800rpm(3:end,3), 1);
r1_1800rpm = -P_Motor1_1800rpm(1);
ub_r1_1800rpm = (Motor1_1800rpm(1,3) - P_Motor1_1800rpm(2))/2;

PelGen_1800rpmM1 = Motor1_1800rpm(:,2).*Motor1_1800rpm(:,3);

% Generator: Motor 1 900rpm

P_Motor1_900rpm = polyfit(Motor1_900rpm(3:end,2), Motor1_900rpm(3:end,3), 1);
r1_900rpm = -P_Motor1_900rpm(1);
ub_r1_900rpm = (Motor1_900rpm(1,3) - P_Motor1_900rpm(2))/2;

PelGen_900rpmM1 = Motor1_900rpm(:,4).*Motor1_900rpm(:,5);


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
r1_warm = mean([2.6 2.4 2.4 2.5]);
r2_warm = mean([2.3 2.2 2.5]);

%% Aufgabe 10

%% Anzeigen der Ergebnisse
disp(' ______   _______          _______  _______ _________ _______  _______ ')
disp('(  __  \ (  ____ \        (       )(  ___  )\__   __/(  ___  )(  ____ )  ')
disp('| (  \  )| (    \/        | () () || (   ) |   ) (   | (   ) || (    )|  ')
disp('| |   ) || |       _____  | || || || |   | |   | |   | |   | || (____)|  ')
disp('| |   | || |      (_____) | |(_)| || |   | |   | |   | |   | ||     __)  ')
disp('| |   ) || |              | |   | || |   | |   | |   | |   | || (\ (     ')
disp('| (__/  )| (____/\        | )   ( || (___) |   | |   | (___) || ) \ \__  ')
disp('(______/ (_______/        |/     \|(_______)   )_(   (_______)|/   \__/ ')
disp('')

% Anzeigen der Ankerwiderstände
disp('Messung Ankerwiderstand (kalt)')
disp(['R_1 = ' num2str(r1) ' Ohm'])
disp(['R_2 = ' num2str(r2) ' Ohm'])

disp('Messung Ankerwiderstand (warm)')
disp(['R_1 = ' num2str(r1_warm) ' Ohm'])
disp(['R_2 = ' num2str(r2_warm) ' Ohm'])

disp('Berechnung Ankerwiderstand aus Kennlinie')
disp('bei n = 900rpm          bei n = 1800rpm')
disp(['R_1 = ' num2str(r1_900rpm) ' Ohm' '        R_1 = ' num2str(r1_1800rpm) ' Ohm'])
disp(['R_2 = ' num2str(r2_900rpm) ' Ohm' '        R_2 = ' num2str(r2_1800rpm) ' Ohm'])

% Anzeigen der c_Phi
disp('Berechnung c * Phi')
disp(['c_Phi 1 = ' num2str(c_phi1) ' V/s'])
disp(['c_Phi 2 = ' num2str(c_phi2) ' V/s'])

% Darstellen Aufgabe 5
title('U/I-Kennlinie Motor 2')
plot(Motor2_1800rpm(:,4), Motor2_1800rpm(:,5), 'LineSmoothing', 'on')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V]')
hold all
grid on
% Pelektrisch Generator
plot (Motor2_1800rpm(:,4),PelGen_1800M2G, 'LineSmoothing', 'on')
% Pelektrisch Motor
plot (Motor2_1800rpm(:,4),PelMot_1800M2G, 'LineSmoothing', 'on')
% Pwelle
plot (Motor2_1800rpm(:,4),Pwelle_1800M2G, 'LineSmoothing', 'on')
% Mwelle
plot (Motor2_1800rpm(:,4),Mwelle_1800M2G, 'LineSmoothing', 'on')
% etawelle
plot (Motor2_1800rpm(:,4),etaGen_1800M2G, 'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'M_{Welle}', '\eta_{Welle}')






