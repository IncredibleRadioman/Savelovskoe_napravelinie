clear
clc
close all
%%
x1 = 2e3;
z1 = 1.5e3;
Vx1 = 100;
Vz1 = 0;
f0 = 1e9;
fs = 4*f0;
T_standing = 1.5e-3;
SNR = 20;
tdiscrete = 3.3e-7;
Q = 25;
[x,z,outSignal,time] = getCoordinatesOfObject(x1,z1,Vx1,Vz1,f0,fs,tdiscrete,T_standing,SNR,[1, 1, 1, -1, 1],Q);
