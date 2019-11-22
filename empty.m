x1 = 3e3;
z1 = 1.6e3;

Vx1 = 1000;
Vz1 = 0;
SNR = 50;

[x,z,outSignal,time] = getCoordinate(x1,z1,100,-50,20);

disp(['Ошибка по X ' num2str(abs(x1-x))]);
disp(['Ошибка по Z ' num2str(abs(z1-z))]);
disp(['Ошибка по дальности ' num2str(abs(sqrt(x1^2+z1^2)-sqrt(x^2+z^2)))]);
