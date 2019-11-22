clear
clc
close all
%%
c = physconst('LightSpeed');
x1 = 1e3;
z1 = 0e3;
Vx1 = 100;
Vz1 = 0;
f0 = 1e9;
fs = 4*f0;
T_standing = 2e-4;
SNR = -20;
tdiscrete = 0.6e-7;
Q = 50;
s0 = [1, 1, 1, -1, 1];
% R_razr = tdiscrete*c/2;
% R_min = tdiscrete*length(s0)*c/2;
% R_max = tdiscrete*length(s0)*Q*c/2;
% disp(['Дальность до цели ' num2str(sqrt(x1^2+z1^2))]);
% disp(['Однозначная дальность ' num2str(R_max)]);
% disp(['Минимальная дальность ' num2str(R_min)]);
% disp(['Дискрет дальности ' num2str(R_razr)]);
[x,z,outSignal,time] = getCoordinatesOfObject(x1,z1,Vx1,Vz1,f0,fs,tdiscrete,T_standing,SNR,s0,Q);
disp(['Ошибка по X ' num2str(abs(x1-x))]);
disp(['Ошибка по Z ' num2str(abs(z1-z))]);
disp(['Ошибка по дальности ' num2str(abs(sqrt(x1^2+z1^2)-sqrt(x^2+z^2)))]);