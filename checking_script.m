clear
clc
close all
%%
x1 = 200;
z1 = 150;
Vx1 = 1e3;
Vz1 = 0;
f0 = 1e9;
fs = 10*f0;
T_standing = 1e-4;
SNR = 100;
T = 0.25e-5;
[x,z,I,Q,S_I,S_Q,time] = getCoordinatesOfObject(x1,z1,Vx1,Vz1,f0,fs,T_standing,SNR,T);
