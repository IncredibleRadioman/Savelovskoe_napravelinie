x1 = 2e3;
z1 = 1e3;

Vx1 = 1000;
Vz1 = 0;
SNR = 50;

f0 = 300e6; %несущая
fs = 10*f0; %частота сэмплирования
T_standing = 7e-5; %время стояния луча


%%
[x,z,I,Q,SI,SQ] = getCoordinates(x1,z1,Vx1,Vz1,f0,fs,T_standing,SNR);
t = 0:1/fs:T_standing;
step = fs/length(SI);
f = -fs/2:step:fs/2-step;

figure;
subplot(2,1,1);
plot(t,I);
title('Signal (I)');
grid on
subplot(2,1,2);
plot(t,Q);
title('Signal (Q)');
grid on


figure;
subplot(2,1,1);
plot(f,10*log10(SI));
title('Specter (I)');
grid on
xlim([0 fs/100]);
subplot(2,1,2);
plot(f,10*log10(SQ));
title('Specter(Q)');
xlim([0 fs/100]);
grid on