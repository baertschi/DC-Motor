% Laborversuch Mechatronik
% Motor Ausmessen

v2hz = @(v) v/14.3*1000/60;
v2rpm = @(v) v/14.3*1000;
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
% Berechnung der theoretischen Drehzahl
nMi_20V = 1/c_phi1*(20-r1_warm*linspace(0,3.5,10)' - 2*ub_r1_1800rpm);
nMi_40V = 1/c_phi1*(40-r1_warm*linspace(0,3.5,10)' - 2*ub_r1_1800rpm);
%% Aufgabe 7
% Soll Speisespannungen: 20V und 40V
Motor1_20V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B3:F9');
Motor1_40V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B12:F16');
Motor2_20V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B23:F27');
Motor2_40V = xlsread('Messresultate.xlsx', 'Tabelle2', 'B30:F34');

% Berechnung Aufgabe 7
% Motor 1 Generator, U = 20V
nMwelle_20V_M1G = v2rpm(Motor1_20V(:,1));
PelMot_20V_M1G = Motor1_20V(:,2).*Motor1_20V(:,3);
PelGen_20V_M1G = Motor1_20V(:,4).*Motor1_20V(:,5);
Mwelle_20V_M1G = 0.5*c_phi1/(2*pi)*(Motor1_20V(:,4)+Motor1_20V(:,2));
Pwelle_20V_M1G = 2*pi*Mwelle_20V_M1G.*v2hz(Motor1_20V(:,1));
etaGen_20V_M1G = PelGen_20V_M1G./Pwelle_20V_M1G;

% Motor 1 Generator, U = 40V
nMwelle_40V_M1G = v2rpm(Motor1_40V(:,1));
PelMot_40V_M1G = Motor1_40V(:,2).*Motor1_40V(:,3);
PelGen_40V_M1G = Motor1_40V(:,4).*Motor1_40V(:,5);
Mwelle_40V_M1G = 0.5*c_phi1/(2*pi)*(Motor1_40V(:,4)+Motor1_40V(:,2));
Pwelle_40V_M1G = 2*pi*Mwelle_40V_M1G.*v2hz(Motor1_40V(:,1));
etaGen_40V_M1G = PelGen_40V_M1G./Pwelle_40V_M1G;

% Motor 2 Generator, U = 20V
nMwelle_20V_M2G = v2rpm(Motor2_20V(:,1));
PelMot_20V_M2G = Motor2_20V(:,4).*Motor2_20V(:,5);
PelGen_20V_M2G = Motor2_20V(:,2).*Motor2_20V(:,3);
Mwelle_20V_M2G = 0.5*c_phi1/(2*pi)*(Motor2_20V(:,2)+Motor2_20V(:,4));
Pwelle_20V_M2G = 2*pi*Mwelle_20V_M2G.*v2hz(Motor2_20V(:,1));
etaGen_20V_M2G = PelGen_20V_M2G./Pwelle_20V_M2G;

% Motor 2 Generator, U = 40V
nMwelle_40V_M2G = v2rpm(Motor2_40V(:,1));
PelMot_40V_M2G = Motor2_40V(:,4).*Motor2_40V(:,5);
PelGen_40V_M2G = Motor2_40V(:,2).*Motor2_40V(:,3);
Mwelle_40V_M2G = 0.5*c_phi1/(2*pi)*(Motor2_40V(:,2)+Motor2_40V(:,4));
Pwelle_40V_M2G = 2*pi*Mwelle_40V_M2G.*v2hz(Motor2_40V(:,1));
etaGen_40V_M2G = PelGen_40V_M2G./Pwelle_40V_M2G;

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

%% Darstellen Aufgabe 5
figure
subplot(1,2,1)

plot(Motor2_1800rpm(:,4), Motor2_1800rpm(:,5), 'LineSmoothing', 'on')
title('Generator: Motor 2, n=1800rpm')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V], P [W]')
hold all
grid on
% Pelektrisch Generator
plot(Motor2_1800rpm(:,4),PelGen_1800M2G, 'LineSmoothing', 'on')
% Pelektrisch Motor
plot(Motor2_1800rpm(:,4),PelMot_1800M2G, 'LineSmoothing', 'on')
% Pwelle
plot(Motor2_1800rpm(:,4),Pwelle_1800M2G, 'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_1800rpm(:,4),Mwelle_1800M2G, Motor2_1800rpm(:,4),etaGen_1800M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on');
set(h2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

% Motor 2 900rpm
figure
subplot(1,2,1)

plot(Motor2_900rpm(:,4), Motor2_900rpm(:,5), 'LineSmoothing', 'on')
title('Generator: Motor 2, n=900rpm')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V], P [W]')
hold all
grid on
% Pelektrisch Generator
plot(Motor2_900rpm(:,4),PelGen_900M2G, 'LineSmoothing', 'on')
% Pelektrisch Motor
plot(Motor2_900rpm(:,4),PelMot_900M2G, 'LineSmoothing', 'on')
% Pwelle
plot(Motor2_900rpm(:,4),Pwelle_900M2G, 'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)

% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_900rpm(:,4),Mwelle_900M2G, Motor2_900rpm(:,4),etaGen_900M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on');
set(h2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

% Motor 1 1800rpm
figure
subplot(1,2,1)

plot(Motor1_1800rpm(:,2), Motor1_1800rpm(:,3), 'LineSmoothing', 'on')
title('Geneartor: Motor 1, n=1800rpm')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V], P [W]')
hold all
grid on
% Pelektrisch Generator
plot(Motor1_1800rpm(:,2),PelGen_1800M1G, 'LineSmoothing', 'on')
% Pelektrisch Motor
plot(Motor1_1800rpm(:,2),PelMot_1800M1G, 'LineSmoothing', 'on')
% Pwelle
plot(Motor1_1800rpm(:,2),Pwelle_1800M1G, 'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_1800rpm(:,2),Mwelle_1800M1G, Motor1_1800rpm(:,2),etaGen_1800M1G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on');
set(h2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

% Motor 1 900rpm
figure
subplot(1,2,1)

plot(Motor1_900rpm(:,2), Motor1_900rpm(:,3), 'LineSmoothing', 'on')
title('Generator: Motor 1, n=900rpm')
xlabel('I_{Gen} [A]')
ylabel('U_{Gen} [V], P [W]')
hold all
grid on
% Pelektrisch Generator
plot(Motor1_900rpm(:,2),PelGen_900M1G, 'LineSmoothing', 'on')
% Pelektrisch Motor
plot(Motor1_900rpm(:,2),PelMot_900M1G, 'LineSmoothing', 'on')
% Pwelle
plot(Motor1_900rpm(:,2),Pwelle_900M1G, 'LineSmoothing', 'on')
legend('U/I-Kennlinie', 'P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_900rpm(:,2),Mwelle_900M1G, Motor1_900rpm(:,2),etaGen_900M1G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on');
set(h2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

% Darstellung Aufgabe 7
% Motor 1 als Generator 20V
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor1_20V(:,2),PelGen_20V_M1G, 'LineSmoothing', 'on')
title('Generator: Motor 1, 20V')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor1_20V(:,2),PelMot_20V_M1G, 'LineSmoothing', 'on')
% Pwelle
plot(Motor1_20V(:,2),Pwelle_20V_M1G, 'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_20V(:,2),Mwelle_20V_M1G, Motor1_20V(:,2),etaGen_20V_M1G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on');
set(h2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

% Motor 1 als Generator 40V
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor1_40V(:,2),PelGen_40V_M1G, 'LineSmoothing', 'on')
title('Generator: Motor 1, 40V')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor1_40V(:,2),PelMot_40V_M1G, 'LineSmoothing', 'on')
% Pwelle
plot(Motor1_40V(:,2),Pwelle_40V_M1G, 'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor1_40V(:,2),Mwelle_40V_M1G, Motor1_40V(:,2),etaGen_40V_M1G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on');
set(h2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

% Motor 2 als Generator 20V
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor2_20V(:,4),PelGen_20V_M2G, 'LineSmoothing', 'on')
title('Generator: Motor 2, 20V')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor2_20V(:,4),PelMot_20V_M2G, 'LineSmoothing', 'on')
% Pwelle
plot(Motor2_20V(:,4),Pwelle_20V_M2G, 'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_20V(:,4),Mwelle_20V_M2G, Motor2_20V(:,4),etaGen_20V_M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on');
set(h2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

% Motor 2 als Generator 40V
figure
subplot(1,2,1)

% Pelektrisch Generator
plot(Motor2_40V(:,4),PelGen_40V_M2G, 'LineSmoothing', 'on')
title('Generator: Motor 2, 40V')
xlabel('I_{Gen} [A]')
ylabel('P [W]')
hold all
grid on
% Pelektrisch Motor
plot(Motor2_40V(:,4),PelMot_40V_M2G, 'LineSmoothing', 'on')
% Pwelle
plot(Motor2_40V(:,4),Pwelle_40V_M2G, 'LineSmoothing', 'on')
legend('P_{el.Gen}', 'P_{el.Mot}', 'P_{Welle}', 'Location', 'NorthWest')

subplot(1,2,2)
% Mwelle und etawelle
[AX,h1,h2] = plotyy(Motor2_40V(:,4),Mwelle_40V_M2G, Motor2_40V(:,4),etaGen_40V_M2G);
title('Moment und Wirkungsgrad');
set(h1,'LineSmoothing', 'on');
set(h2,'LineSmoothing', 'on');
xlabel('I_{Gen} [A]')
ylabel('M [Nm]');
set(get(AX(2),'Ylabel'),'String','\eta') 
grid on
legend('M_{Welle}', '\eta_{Welle}')

