clear
clc
close all
%%
%������ �������� ��������� ������������

%��������� ���
x0 = 0;
y0 = 0;
z0 = 0;

phi_main = 30; %������ �� �� �������
theta_main = 30; %�� ���� �����
discrete = 1; %������� �����
f0 = 100e6; %�������
fs = 10*f0; %������� �������������
T_standing = 10e-5; %����� ������� ����
N = floor(T_standing / (1/fs) ); %����� ����� �������
phi_s = 0; %��������� ���� �������
s0 = [1 1 1 -1 1];
timp = 1e-5; %������������ ������������ ��������
SNR = -10; %�/� � ��
dsw = 1;


%%
%�� ������ ������������ (������� ����), ���� ������ ��������
phi0 = 0;
theta0 = 0;

res = formDgrm(phi0,theta0,phi_main,theta_main,discrete);

f = res.values;
phi = res.phis;
theta = res.thetas;

figure;
surf(phi,theta,10*log10(f),'EdgeColor','none');
zlim([-30 0]);

%%
%������� ���������� ������� ����������
x1 = 2e3;
y1 = 2e3;
z1 = 1e3;

Vx1 = 1000;
Vy1 = 0;
Vz1 = 0;

%������� �������� � ������� �������
delay = getObjDelay(x1,y1,z1,x0,y0,z0,fs);
fd = getObjFd(Vx1,Vy1,Vz1,theta0,phi0,f0);
%��������� � ������������ � ��
a = getObjAmplitude(x1,y1,z1,f,discrete);
%������ �� ��
t = 0:1/fs:T_standing;
s = a*getZondSignal(f0,t,phi_s,delay,fd,s0,timp);
s = awgn(s,SNR);

sI = real(s);
sQ = imag(s);




%%
%�������
so = getCarrier(f0,t,phi_s);
soI = real(so);
soQ = imag(so);


%%
%������� � �������
sI = sI.*soI;
sQ = sQ.*soQ;


filt = fir1(34,0.1,'low',chebwin(35,30));

sI = filter(filt,1,sI);
sQ = filter(filt,1,sQ);


s = sI + 1i*sQ;

S = fft(s);
SI = real(S);
SQ = imag(S);

%%
%������� ���
code = getCoder(t,dsw,s0,timp);
t0 = T_standing/2;
Scode = getFilter(code,fs,t0);


%%
%������� � �������� ����
SI = SI.*Scode;
SQ = SQ.*Scode;

% SI = real(S);
% SQ = imag(S);

figure;
SpI = fftshift(abs(SI));
SpQ = fftshift(abs(SQ));
step = fs/length(SI);
freq = -fs/2:step:fs/2-step;
subplot(2,1,1);
plot(freq,10*log10(SpI));
grid on
title('After filter (I)');
xlim([0 20/timp]);
subplot(2,1,2);
plot(freq,10*log10(SpQ));
grid on
title('After filter (Q)');
xlim([0 20/timp]);

S = SI + 1i*SQ;

%%
%������ �� ������ ��
signal = ifft(S);
signalI = fftshift(real(signal));
signalQ = fftshift(imag(signal));



figure;
subplot(2,1,1);
plot(t,signalI);
grid on
title('After filter (I)');
subplot(2,1,2);
plot(t,signalQ);
grid on
title('After filter (Q)');


pI = 0;
pQ = 0;
for i=1:length(signalI)
    
    pI = pI + signalI(i)^2;
    pQ = pQ + signalQ(i)^2;
    
end

pI = pI/length(signalI);
pQ = pQ/length(signalI);
