clc
clear
close all
RLS = RLS_Class;
RLS.tsym = 1e-7;
t = linspace(70,80,200);
x0 = 500;
z0 = 450;
speed = 15;
angle = 20;
[x1,z1,Vx,Vz] = getTargetCoord(RLS,speed,x0,z0,angle,t);
figure;
plot(x1,z1);
x = zeros(1,length(x1));
z = zeros(1,length(x1));
for i = 1:length(x1)
    [x(i),z(i),~,~] = getCoordinate(RLS,x1(i),z1(i),Vx,Vz,-15);
end
hold on;
plot(x,z);
figure;
plot(sqrt(x1.^2+z1.^2)-sqrt(x.^2+z.^2))
