function diagramm = formDgrm(phi0,phi_main,discrete)
%формирование ДН phi0 - угол по азимуту, theta0 - угол места
%phi_main - ширина ДН по азимуту, theta_main - ширина ДН по углу места
%discrete - шаг по углу (все задавать в градусах)
%задаем векторы углов
k = pi/180;
discrete = discrete * k;
phi = 0:discrete:2*pi;

phi_main = phi_main * k;


%коэффициенты для луча ДН
k_phi = pi/(phi_main/2);

phi0 = phi0 * k;

%формируем ДН по азимуту
f = zeros(1,length(phi));


for i=1:length(phi)
   
    f(i) = abs( sin(k_phi*(phi(i) - phi0))/( k_phi *(phi(i) - phi0))   );
    if(isnan(f(i)))
        f(i) = 1;
    end
    
end

phi = phi * 1/k;
%формируем ДН по углу места

diagramm.values = f;
diagramm.phis = phi;