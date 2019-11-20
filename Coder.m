function out = Decoder(fs,s0,timp,T,T_standing)

%вычислим длительность одного символа последовательности
tsym = timp/length(s0);
%вектор времени символа
tsym1 = 0:1/fs:tsym;
%формируем вектор импульса
ssym1 = zeros(1,length(tsym1)*length(s0));
n = 0;
for i=1:length(s0)
    
    ssym1(n*length(tsym1)+1:(n+1)*length(tsym1)) = s0(i);
    n = n + 1;
    
end
%дополняем нулями
tzeros = 0:1/fs:T;
simp1 = zeros(1,length(tzeros));
simp1(1:length(ssym1)) = ssym1(:);
%один импульс готов, теперь необходимо повторить их до конца времени
%стояния луча
%общее число импульсов
N = floor(T_standing/T);
%формируем вектор импульсов
simp = zeros(1,N*length(simp1));
n = 0;
for i=1:N
    
    simp(n*length(simp1)+1:(n+1)*length(simp1)) = simp1(:);
    n = n+1;
    
end

end