function delay = getObjDelay(x1,z1,x0,z0,fs)
%���������� �������� ������� �� ����������� �������
R = sqrt((x1-x0)^2 + (z1-z0)^2);
c = 3e8;
delay = 2*R/c; %�������� � ���
delay = floor(delay / (1/fs) ); %�������� � �������