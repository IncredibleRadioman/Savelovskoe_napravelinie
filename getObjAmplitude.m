function a = getObjAmplitude(x1,z1,f,discrete)
%определение амплитуды сигнала, приходящего от объекта
k = 180/pi;

if(x1>0)
    phi1 = atan(z1/x1) * k;
else
    phi1 = (pi - abs(atan(z1/x1)))*k;
end

index_phi = floor(phi1 / discrete);
% max = 365;
% for i=1:length(phi)
%    
%     if((phi1 - phi(i)) < max)
%         max = phi1 - phi(i);
%         index_phi = i;
%     end
%     
% end

a = f(index_phi);