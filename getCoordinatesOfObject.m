function [x,z,outSignal,time] = getCoordinatesOfObject(x1,z1,Vx1,Vz1,f0,fs,tdiscrete,T_standing,SNR,s0,Q)

phi_main = 30; %������ �� �� �������
k_phi = pi/(phi_main*pi/180/2); %����������� ��
discrete = 5; %������� �����
c = physconst('LightSpeed'); %�������� �����
timp = tdiscrete * length(s0); %������������ ��������
T = timp * Q;
R_razr = tdiscrete*c/2;
R_min = timp*c/2;
R_max = T*c/2;
disp(['��������� �� ���� ' num2str(sqrt(x1^2+z1^2))]);
disp(['����������� ��������� ' num2str(R_max)]);
disp(['����������� ��������� ' num2str(R_min)]);
disp(['������� ��������� ' num2str(R_razr)]);
%������ ���� ��
if(z1>=0)&&(x1>=0)
    phi_true = atan(z1/x1);
else
    if(z1>=0)&&(x1<0)
        phi_true = pi - atan(abs(z1)/abs(x1));
    else
        if(z1<0)&&(x1>=0)
            phi_true = 2*pi - atan(abs(z1)/abs(x1));
        else
            phi_true = pi + atan(abs(z1)/abs(x1));
        end
    end
end
phi = round(rad2deg(phi_true)/discrete)*discrete;
phi = deg2rad(phi);


%��������� ��������
R = sqrt(x1^2 + z1^2);
delay = 2*R/c;
%���������
a = abs( ( sin(k_phi*(phi_true-phi)) ) / ( ( k_phi*(phi_true-phi)) ) );
%�������� ������������ �����
%������� �������� ������� �������� �� ����� �����������
v = Vx1*cos(phi) + Vz1*sin(phi);
fd = -2*v*f0/c; %������������ �������
%��������� �������� ������
%��������� �������
out = ZondSignal(a,delay,fd,f0,fs,s0,timp,T,T_standing);
s = out.signal;
t = out.time;
%����������� ���
s = awgn(s,SNR);
%��������� ������
sI = real(s);
sQ = imag(s);
%������� ������
% so =  exp(1i*2*pi*f0.*t);
soI = cos(2*pi*f0.*t);
soQ = sin(2*pi*f0.*t);
%������� � �������
sI = sI.*soI;
sQ = sQ.*soQ;
%���������
filt = fir1(34,0.1,'low',chebwin(35,30));
sI = filter(filt,1,sI);
sQ = filter(filt,1,sQ);
%������ ���
s = sI + 1i*sQ;
S = fft(s);
SI = real(S);
SQ = imag(S);
%��
Scode = Decoder(fs,s0,timp,T,T_standing);

SI = SI.*abs(Scode);
SQ = SQ.*abs(Scode);
% S = (SI + 1i*SQ).*Scode;
S = (SI + 1i*SQ);

signal = fftshift(abs(ifft(S)));
% signalI = abs(signalI);
% signalQ = abs(signalQ);
[~,idx] = max(signal);

tau = (idx-1)/fs;


R = c*tau/2;



x = R*cos(phi);
z = R*sin(phi);
outSignal = signal;
time = t;


end
