function s = getZondSignal(f0,t,phi_s,delay,fd,s0,timp,fs)
%получение единичного зондирующего сигнала
%формируем гарм часть
N = length(t);
M = length(s0);
t_sym = timp / M;
s1 = exp(1i*2*pi*(f0+fd).*t + phi_s);
Ncalls = timp*fs;


%формируем последовательность
s2 = zeros(1,N);
for i=1:Ncalls
   
    %вычислим номер символа
    
    n = floor(t(i)/t_sym) + 1;
    if (n <= M)
        s2(i) = s0(n);
    end
    
    
end
s_0 = s1.*s2;
%теперь задержка
s_d = zeros(1,N+delay);
s_d(delay:N+delay-1) = s_0;
s = s_d(1:N);