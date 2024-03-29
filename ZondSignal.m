function out = ZondSignal(a,delay,fd,f0,fs,s0,timp,T,T_standing)

%�������� ������������ ������ ������� ������������������
tsym = timp/length(s0);
%������ ������� �������
tsym1 = 0:1/fs:tsym;
%��������� ������ ��������
ssym1 = zeros(1,length(tsym1)*length(s0));
n = 0;
for i=1:length(s0)
    
    ssym1(n*length(tsym1)+1:(n+1)*length(tsym1)) = s0(i);
    n = n + 1;
    
end
%��������� ������
tzeros = 0:1/fs:T;
simp1 = zeros(1,length(tzeros));
simp1(1:length(ssym1)) = ssym1(:);
%���� ������� �����, ������ ���������� ��������� �� �� ����� �������
%������� ����
%����� ����� ���������
N = floor(T_standing/T);
%��������� ������ ���������
simp = zeros(1,N*length(simp1));
n = 0;
for i=1:N
    
    simp(n*length(simp1)+1:(n+1)*length(simp1)) = simp1(:);
    n = n+1;
    
end
%�������� �������� � ��������
if(delay>0)
    
    delayInSamples = round(delay*fs);
    stemp = zeros(1,length(simp)+delayInSamples);
    stemp(delayInSamples+1:length(simp)+delayInSamples) = simp;
    s = a*stemp(1:length(simp));
    
else
    
    s = a*simp;
    
end


%������ ��������� �� �������
t = 0:1/fs:(length(simp)-1)*1/fs;
scar = exp(1i*2*pi*(f0+fd).*t);

s = s.*scar;


out.signal = s;
out.time = t;


end