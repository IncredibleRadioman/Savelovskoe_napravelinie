function s = getCoder(t,delay,s0,timp,fs)
%получение единичного зондирующего сигнала
%формируем гарм часть
N = length(t);
t_sym = timp / length(s0);
Ncalls = timp*fs;

%формируем последовательность
s2 = zeros(1,N);
for i=1:Ncalls
   
    %вычислим номер символа
    
    n = floor(t(i)/t_sym) + 1;
    if (n <= length(s0))
        s2(i) = s0(n);
    end
    
    
end
s_0 = s2;
%теперь задержка
s_d = zeros(1,N+delay);
s_d(delay:N+delay-1) = s_0;
s = s_d(1:N);