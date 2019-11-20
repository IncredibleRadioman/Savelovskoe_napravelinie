function diagramm = formDgrm(phi0,phi_main,discrete)
%������������ �� phi0 - ���� �� �������, theta0 - ���� �����
%phi_main - ������ �� �� �������, theta_main - ������ �� �� ���� �����
%discrete - ��� �� ���� (��� �������� � ��������)
%������ ������� �����
k = pi/180;
discrete = discrete * k;
phi = 0:discrete:2*pi;

phi_main = phi_main * k;


%������������ ��� ���� ��
k_phi = pi/(phi_main/2);

phi0 = phi0 * k;

%��������� �� �� �������
f = zeros(1,length(phi));


for i=1:length(phi)
   
    f(i) = abs( sin(k_phi*(phi(i) - phi0))/( k_phi *(phi(i) - phi0))   );
    if(isnan(f(i)))
        f(i) = 1;
    end
    
end

phi = phi * 1/k;
%��������� �� �� ���� �����

diagramm.values = f;
diagramm.phis = phi;