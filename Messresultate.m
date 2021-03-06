% Laborversuch Mechatronik
% Motor Ausmessen

clear all; close all

v2hz = @(v) v/14.3*1000/60;
v2rpm = @(v) v/14.3*1000;
rpm2v = @(rpm) rpm/1000*14.3;
hz2rpm = @(hz) hz*60;

%% Aufgabe 2
% Widerstand variiert je nach Rotorstellung:
r1 = mean([3.3 2.7 3.0 3.6]);
r2 = mean([2.4 2.7 2.9 3.2]);

% Herauslesen der warmen Widerstände nach Augfgabe 10:
r1_warm = mean([2.6 2.4 2.4 2.5]);
r2_warm = mean([2.3 2.2 2.5 2.4]);

% für die Berechnung der Widerstände im drehenden Zustand mit POLYFIT siehe
% Aufgabe 5!!!

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

%% Berechnungen Aufgabe 5

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

PelGen_900M2G = Motor2_900rpm(:,4).*Motor2_900rpm(:,5);
PelMot_900M2G = Motor2_900rpm(:,2).*Motor2_900rpm(:,3);
Mwelle_900M2G = 0.5*c_phi1/(2*pi)*(Motor2_900rpm(:,2)+Motor2_900rpm(:,4));
Pwelle_900M2G = 2*pi*Mwelle_900M2G.*v2hz(Motor2_900rpm(:,1));
etaGen_900M2G = PelGen_900M2G./Pwelle_900M2G;
% Generator: Motor 1 1800rpm

P_Motor1_1800rpm = polyfit(Motor1_1800rpm(3:end,2), Motor1_1800rpm(3:end,3), 1);
r1_1800rpm = -P_Motor1_1800rpm(1);
ub_r1_1800rpm = (Motor1_1800rpm(1,3) - P_Motor1_1800rpm(2))/2;

% PelGen_1800rpmM1 = Motor1_1800rpm(:,2).*Motor1_1800rpm(:,3);
PelGen_1800M1G = Motor1_1800rpm(:,2).*Motor1_1800rpm(:,3);
PelMot_1800M1G = Motor1_1800rpm(:,4).*Motor1_1800rpm(:,5);
Mwelle_1800M1G = 0.5*c_phi1/(2*pi)*(Motor1_1800rpm(:,4)+Motor1_1800rpm(:,2));
Pwelle_1800M1G = 2*pi*Mwelle_1800M1G.*v2hz(Motor1_1800rpm(:,1));
etaGen_1800M1G = PelGen_1800M1G./Pwelle_1800M1G;

% Generator: Motor 1 900rpm

P_Motor1_900rpm = polyfit(Motor1_900rpm(3:end,2), Motor1_900rpm(3:end,3), 1);
r1_900rpm = -P_Motor1_900rpm(1);
ub_r1_900rpm = (Motor1_900rpm(1,3) - P_Motor1_900rpm(2))/2;

% PelGen_900rpmM1 = Motor1_900rpm(:,4).*Motor1_900rpm(:,5);
PelGen_900M1G = Motor1_900rpm(:,2).*Motor1_900rpm(:,3);
PelMot_900M1G = Motor1_900rpm(:,4).*Motor1_900rpm(:,5);
Mwelle_900M1G = 0.5*c_phi1/(2*pi)*(Motor1_900rpm(:,4)+Motor1_900rpm(:,2));
Pwelle_900M1G = 2*pi*Mwelle_900M1G.*v2hz(Motor1_900rpm(:,1));
etaGen_900M1G = PelGen_900M1G./Pwelle_900M1G;

%% Aufgabe 6
% --> kommt nach aufgabe 7!!!

%% Aufgabe 7 (Einlesen)
% Soll Speisespannungen: 20V und 40V
Motor1_20V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B3:F9');
Motor1_40V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B12:F16');
Motor2_20V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B23:F27');
Motor2_40V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B30:F34');

%% Aufgabe 6
% Berechnung der theoretischen Drehzahl
nMi_20V_M1G = 1/c_phi1*(20-r1_warm*Motor1_20V(:,2) - 2*ub_r1_1800rpm);
nMi_20V_M2G = 1/c_phi1*(20-r1_warm*Motor2_20V(:,2) - 2*ub_r2_1800rpm);
nMi_40V_M1G = 1/c_phi1*(40-r1_warm*Motor1_40V(:,2) - 2*ub_r1_1800rpm);
nMi_40V_M2G = 1/c_phi1*(40-r1_warm*Motor2_40V(:,2) - 2*ub_r2_1800rpm);

Mi_20V_M1G = c_phi1/(2*pi)*Motor1_20V(:,2);
Mi_20V_M2G = c_phi1/(2*pi)*Motor2_20V(:,2);
Mi_40V_M1G = c_phi1/(2*pi)*Motor1_40V(:,2);
Mi_40V_M2G = c_phi1/(2*pi)*Motor2_40V(:,2);

%% Aufgabe 7
% Berechnung Aufgabe 7
% Motor 1 Generator, U = 20V
%nMwelle_20V_M1G = v2rpm(Motor1_20V(:,1));
PelMot_20V_M1G = Motor1_20V(:,2).*Motor1_20V(:,3);
PelGen_20V_M1G = Motor1_20V(:,4).*Motor1_20V(:,5);
Mwelle_20V_M1G = 0.5*c_phi1/(2*pi)*(Motor1_20V(:,4)+Motor1_20V(:,2));
Pwelle_20V_M1G = 2*pi*Mwelle_20V_M1G.*v2hz(Motor1_20V(:,1));
etaGen_20V_M1G = PelGen_20V_M1G./Pwelle_20V_M1G;

% Motor 1 Generator, U = 40V
%nMwelle_40V_M1G = v2rpm(Motor1_40V(:,1));
PelMot_40V_M1G = Motor1_40V(:,2).*Motor1_40V(:,3);
PelGen_40V_M1G = Motor1_40V(:,4).*Motor1_40V(:,5);
Mwelle_40V_M1G = 0.5*c_phi1/(2*pi)*(Motor1_40V(:,4)+Motor1_40V(:,2));
Pwelle_40V_M1G = 2*pi*Mwelle_40V_M1G.*v2hz(Motor1_40V(:,1));
etaGen_40V_M1G = PelGen_40V_M1G./Pwelle_40V_M1G;

% Motor 2 Generator, U = 20V
%nMwelle_20V_M2G = v2rpm(Motor2_20V(:,1));
PelMot_20V_M2G = Motor2_20V(:,4).*Motor2_20V(:,5);
PelGen_20V_M2G = Motor2_20V(:,2).*Motor2_20V(:,3);
Mwelle_20V_M2G = 0.5*c_phi1/(2*pi)*(Motor2_20V(:,2)+Motor2_20V(:,4));
Pwelle_20V_M2G = 2*pi*Mwelle_20V_M2G.*v2hz(Motor2_20V(:,1));
etaGen_20V_M2G = PelGen_20V_M2G./Pwelle_20V_M2G;

% Motor 2 Generator, U = 40V
%nMwelle_40V_M2G = v2rpm(Motor2_40V(:,1));
PelMot_40V_M2G = Motor2_40V(:,4).*Motor2_40V(:,5);
PelGen_40V_M2G = Motor2_40V(:,2).*Motor2_40V(:,3);
Mwelle_40V_M2G = 0.5*c_phi1/(2*pi)*(Motor2_40V(:,2)+Motor2_40V(:,4));
Pwelle_40V_M2G = 2*pi*Mwelle_40V_M2G.*v2hz(Motor2_40V(:,1));
etaGen_40V_M2G = PelGen_40V_M2G./Pwelle_40V_M2G;

%% Aufgabe 8
% Soll Speisespannung: 40V (mit Vorwiderstand)
Motor1_10Ohm= xlsread('Messresultate.xlsx', 'Tabelle3', 'B3:F8');
Motor2_10Ohm = xlsread('Messresultate.xlsx', 'Tabelle3', 'B16:F20');

% Motor 1 Generator, Rv = 10Ohm
%nMwelle_10Ohm_M1G = v2rpm(Motor1_10Ohm(:,1));
PelMot_10Ohm_M1G = Motor1_10Ohm(:,2).*(40-Motor1_10Ohm(:,3));
PelGen_10Ohm_M1G = Motor1_10Ohm(:,4).*Motor1_10Ohm(:,5);
PelRes_10Ohm_M1G = Motor1_10Ohm(:,2).*Motor1_10Ohm(:,3);
Mwelle_10Ohm_M1G = 0.5*c_phi1/(2*pi)*(Motor1_10Ohm(:,4)+Motor1_10Ohm(:,2));
Pwelle_10Ohm_M1G = 2*pi*Mwelle_10Ohm_M1G.*v2hz(Motor1_10Ohm(:,1));
etaGen_10Ohm_M1G = PelGen_10Ohm_M1G./Pwelle_10Ohm_M1G;

% Motor 2 Generator, Rv = 10Ohm
%nMwelle_10Ohm_M2G = v2rpm(Motor2_10Ohm(:,1));
PelMot_10Ohm_M2G = Motor2_10Ohm(:,4).*(40-Motor2_10Ohm(:,5));
PelGen_10Ohm_M2G = Motor2_10Ohm(:,2).*Motor2_10Ohm(:,3);
PelRes_10Ohm_M2G = Motor2_10Ohm(:,4).*Motor2_10Ohm(:,5);
Mwelle_10Ohm_M2G = 0.5*c_phi1/(2*pi)*(Motor2_10Ohm(:,2)+Motor2_10Ohm(:,4));
Pwelle_10Ohm_M2G = 2*pi*Mwelle_10Ohm_M2G.*v2hz(Motor2_10Ohm(:,1));
etaGen_10Ohm_M2G = PelGen_10Ohm_M2G./Pwelle_10Ohm_M2G;

%% Aufgabe 9


%% Aufgabe 10
% siehe Aufgabe 2!!

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

%% Darstellen Aufgabe 5 --> schönere Darstellung mit f=figure; set(f, 'Units', 'normalized', 'Position', [0.2, 0.1, 0.7, 0.5]);
figure
subplot(1,2,1)

plot(Motor2_1800rpm(:,4), Motor2_1800rpm(:,5), 'LineWidth', 2, 'LineSmoothing', 'on')
title('Generator: Motor 2, n=1800rpm')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V], P [W]')
hold all
grid on
% Pelektrisch Generator
plot(Motor2_1800rpm(:,4),PelGen_1800M2G, 'LineWidth', 2, 'LineSmoothing', 'on')
% Pelektrisch Motor
plot(Motor2_1800rpm(:,4),PelMot_1800M2G, 'LineWidth', 2,'LineSmoothing', 'on')
% Pwelle
plot(Motor2_1800rpm(:,4),Pwelle_1800M2G,'LineWidth', 2, 'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_1800rpm(:,4),Mwelle_1800M2G, Motor2_1800rpm(:,4),etaGen_1800M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on', 'LineWidth', 2);
set(h2,'LineSmoothing', 'on', 'LineWidth', 2);
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe5-motor1-1800rpm.png'];
print('-dpng', filename);

% Motor 2 900rpm
figure
subplot(1,2,1)

plot(Motor2_900rpm(:,4), Motor2_900rpm(:,5), 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 2, n=900rpm')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V], P [W]')
hold all
grid on
% Pelektrisch Generator
plot(Motor2_900rpm(:,4),PelGen_900M2G, 'LineWidth', 2,'LineSmoothing', 'on')
% Pelektrisch Motor
plot(Motor2_900rpm(:,4),PelMot_900M2G, 'LineWidth', 2,'LineSmoothing', 'on')
% Pwelle
plot(Motor2_900rpm(:,4),Pwelle_900M2G, 'LineWidth', 2,'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)

% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_900rpm(:,4),Mwelle_900M2G, Motor2_900rpm(:,4),etaGen_900M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on', 'LineWidth', 2);
set(h2,'LineSmoothing', 'on', 'LineWidth', 2);
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe5-motor1-900rpm.png'];
print('-dpng', filename);

% Motor 1 1800rpm
figure
subplot(1,2,1)

plot(Motor1_1800rpm(:,2), Motor1_1800rpm(:,3), 'LineWidth', 2, 'LineSmoothing', 'on')
title('Geneartor: Motor 1, n=1800rpm')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V], P [W]')
hold all
grid on
% Pelektrisch Generator
plot(Motor1_1800rpm(:,2),PelGen_1800M1G,  'LineWidth', 2,'LineSmoothing', 'on')
% Pelektrisch Motor
plot(Motor1_1800rpm(:,2),PelMot_1800M1G,  'LineWidth', 2,'LineSmoothing', 'on')
% Pwelle
plot(Motor1_1800rpm(:,2),Pwelle_1800M1G,  'LineWidth', 2,'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_1800rpm(:,2),Mwelle_1800M1G, Motor1_1800rpm(:,2),etaGen_1800M1G);
title('Moment und Wirkungsgrad');
set(h1, 'LineWidth', 2, 'LineSmoothing', 'on');
set(h2, 'LineWidth', 2, 'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe5-motor2-1800rpm.png'];
print('-dpng', filename);

% Motor 1 900rpm
figure
subplot(1,2,1)

plot(Motor1_900rpm(:,2), Motor1_900rpm(:,3), 'LineWidth', 2, 'LineSmoothing', 'on')
title('Generator: Motor 1, n=900rpm')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V], P [W]')
hold all
grid on
% Pelektrisch Generator
plot(Motor1_900rpm(:,2),PelGen_900M1G,'LineWidth', 2, 'LineSmoothing', 'on')
% Pelektrisch Motor
plot(Motor1_900rpm(:,2),PelMot_900M1G, 'LineWidth', 2,'LineSmoothing', 'on')
% Pwelle
plot(Motor1_900rpm(:,2),Pwelle_900M1G, 'LineWidth', 2,'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_900rpm(:,2),Mwelle_900M1G, Motor1_900rpm(:,2),etaGen_900M1G);
title('Moment und Wirkungsgrad');
set(h1,'LineWidth', 2,'LineSmoothing', 'on');
set(h2,'LineWidth', 2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe5-motor2-900rpm.png'];
print('-dpng', filename);

%% Darstellung Aufgabe 6 und Aufgabe 7 (Drehzahlen)
% Motor 1 als Generator 20V und 40V
figure

subplot(1,2,1)
% Drehzahl in Abhänigkeit von Mi (Aufgabe 6)
plot(Mi_20V_M1G,hz2rpm(nMi_20V_M1G), 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 1, 20V und 40V')
xlabel('M_{i} [Nm]')
ylabel('n [rpm]')
hold all
plot(Mi_40V_M1G,hz2rpm(nMi_40V_M1G), 'LineWidth', 2,'LineSmoothing', 'on')
legend('U_{A} = 20V', 'U_{A} = 40V', 'Location', 'East')
grid on

subplot(1,2,2)
% Drehzahl in Abhänigkeit von MWelle (Aufgabe 7)
plot(Mwelle_20V_M1G,hz2rpm(nMi_20V_M1G), 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 1, 20V und 40V')
xlabel('M_{Welle} [Nm]')
ylabel('n [rpm]')
hold all
plot(Mwelle_40V_M1G,hz2rpm(nMi_40V_M1G), 'LineWidth', 2,'LineSmoothing', 'on')
legend('U_{A} = 20V', 'U_{A} = 40V', 'Location', 'East')
grid on

filename = ['plots/aufgabe6-motor1.png'];
print('-dpng', filename);

% Motor 1 als Generator 20V und 40V
figure

subplot(1,2,1)
% Drehzahl in Abhänigkeit von Mi (Aufgabe 6)
plot(Mi_20V_M2G,hz2rpm(nMi_20V_M2G), 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 2, 20V und 40V')
xlabel('M_{i} [Nm]')
ylabel('n [rpm]')
hold all
plot(Mi_40V_M2G,hz2rpm(nMi_40V_M2G), 'LineWidth', 2,'LineSmoothing', 'on')
legend('U_{A} = 20V', 'U_{A} = 40V', 'Location', 'East')
grid on

subplot(1,2,2)
% Drehzahl in Abhänigkeit von MWelle (Aufgabe 7)
plot(Mwelle_20V_M2G,hz2rpm(nMi_20V_M2G), 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 2, 20V und 40V')
xlabel('M_{Welle} [Nm]')
ylabel('n [rpm]')
hold all
plot(Mwelle_40V_M2G,hz2rpm(nMi_40V_M2G), 'LineWidth', 2,'LineSmoothing', 'on')
legend('U_{A} = 20V', 'U_{A} = 40V', 'Location', 'East')
grid on

filename = ['plots/aufgabe6-motor2.png'];
print('-dpng', filename);

%% Darstellung Aufgabe 7
% Motor 1 als Generator 20V
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor1_20V(:,2),PelGen_20V_M1G, 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 1, 20V')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor1_20V(:,2),PelMot_20V_M1G, 'LineWidth', 2,'LineSmoothing', 'on')
% Pwelle
plot(Motor1_20V(:,2),Pwelle_20V_M1G, 'LineWidth', 2,'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_20V(:,2),Mwelle_20V_M1G, Motor1_20V(:,2),etaGen_20V_M1G);
title('Moment und Wirkungsgrad');
set(h1,'LineWidth', 2,'LineSmoothing', 'on');
set(h2,'LineWidth', 2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe7-motor2-20V.png'];
print('-dpng', filename);

% Motor 1 als Generator 40V
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor1_40V(:,2),PelGen_40V_M1G,'LineWidth', 2, 'LineSmoothing', 'on')
title('Generator: Motor 1, 40V')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor1_40V(:,2),PelMot_40V_M1G, 'LineWidth', 2,'LineSmoothing', 'on')
% Pwelle
plot(Motor1_40V(:,2),Pwelle_40V_M1G, 'LineWidth', 2,'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_40V(:,2),Mwelle_40V_M1G, Motor1_40V(:,2),etaGen_40V_M1G);
title('Moment und Wirkungsgrad');
set(h1,'LineWidth', 2,'LineSmoothing', 'on');
set(h2,'LineWidth', 2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe7-motor2-40V.png'];
print('-dpng', filename);

% Motor 2 als Generator 20V
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor2_20V(:,4),PelGen_20V_M2G, 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 2, 20V')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor2_20V(:,4),PelMot_20V_M2G,'LineWidth', 2, 'LineSmoothing', 'on')
% Pwelle
plot(Motor2_20V(:,4),Pwelle_20V_M2G, 'LineWidth', 2,'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_20V(:,4),Mwelle_20V_M2G, Motor2_20V(:,4),etaGen_20V_M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineWidth', 2,'LineSmoothing', 'on');
set(h2,'LineWidth', 2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe7-motor1-20V.png'];
print('-dpng', filename);

% Motor 2 als Generator 40V
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor2_40V(:,4),PelGen_40V_M2G, 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 2, 40V')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor2_40V(:,4),PelMot_40V_M2G,'LineWidth', 2, 'LineSmoothing', 'on')
% Pwelle
plot(Motor2_40V(:,4),Pwelle_40V_M2G,'LineWidth', 2, 'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_40V(:,4),Mwelle_40V_M2G, Motor2_40V(:,4),etaGen_40V_M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineWidth', 2,'LineSmoothing', 'on');
set(h2,'LineWidth', 2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe7-motor1-40V.png'];
print('-dpng', filename);

%% Darstellung Aufgabe 8
% Motor 2 als Anreger, Rv = 10Ohm
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor1_10Ohm(:,4),PelGen_10Ohm_M1G,'LineWidth', 2, 'LineSmoothing', 'on')
title('Generator: Motor 2, mit Vorwiderstand')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor1_10Ohm(:,4),PelMot_10Ohm_M1G,'LineWidth', 2, 'LineSmoothing', 'on')
% Pwelle
plot(Motor1_10Ohm(:,4),Pwelle_10Ohm_M1G,'LineWidth', 2, 'LineSmoothing', 'on')
% Pvorwiderstand
plot(Motor1_10Ohm(:,4),PelRes_10Ohm_M1G,'LineWidth', 2, 'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'P_{Rvor}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_10Ohm(:,4),Mwelle_10Ohm_M1G, Motor1_10Ohm(:,4),etaGen_10Ohm_M1G);
title('Moment und Wirkungsgrad');
set(h1,'LineWidth', 2,'LineSmoothing', 'on');
set(h2,'LineWidth', 2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe8-motor1-10Ohm.png'];
print('-dpng', filename);


% Motor 1 als Anreger, Rv = 10Ohm
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor2_10Ohm(:,2),PelGen_10Ohm_M2G, 'LineWidth', 2,'LineSmoothing', 'on')
title('Generator: Motor 1, mit Vorwiderstand')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor2_10Ohm(:,2),PelMot_10Ohm_M2G, 'LineWidth', 2,'LineSmoothing', 'on')
% Pwelle
plot(Motor2_10Ohm(:,2),Pwelle_10Ohm_M2G, 'LineWidth', 2,'LineSmoothing', 'on')
% Pvorwiderstand
plot(Motor2_10Ohm(:,2),PelRes_10Ohm_M2G, 'LineWidth', 2,'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'P_{Rvor}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_10Ohm(:,2),Mwelle_10Ohm_M2G, Motor2_10Ohm(:,2),etaGen_10Ohm_M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineWidth', 2,'LineSmoothing', 'on');
set(h2,'LineWidth', 2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

filename = ['plots/aufgabe8-motor2-10Ohm.png'];
print('-dpng', filename);

%% Darstellung Aufgabe 9
% Motor 1 als Generator, 40V und beim höchsten Strom:

disp('Berechnung Summe Eisen- und mechanische Verluste')
PEisenMech_Summe = (1-etaGen_40V_M1G(end))*PelMot_40V_M1G(end);
disp(['P_e+m = ' num2str(PEisenMech_Summe) ' W']);