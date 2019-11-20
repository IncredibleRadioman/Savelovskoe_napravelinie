function [x,z,I,Q,S_I,S_Q] = getCoordinates(x1,z1,Vx1,Vz1,f0,fs,T_standing,SNR,start_angle,finish_angle)

phi_main = 30; %ширина ДН по азимуту
discrete = 1; %дискрет углов
phi_s = 0; %начальная фаза сигнала
s0 = [1 1 1 -1 1];
timp = 1e-6; %длительность зондирующего импульса
dsw = 1;
c = 3e8;

Pmax = 0;
for phi0=start_angle:5:finish_angle
        
        res = formDgrm(phi0,phi_main,discrete);
        
        f = res.values;
        
        
        delay = getObjDelay(x1,z1,0,0,fs);
        fd = getObjFd(Vx1,Vz1,phi0,f0);
        a = getObjAmplitude(x1,z1,f,discrete);
        t = 0:1/fs:T_standing;
        s = a*getZondSignal(f0,t,phi_s,delay,fd,s0,timp,fs);
        s = awgn(s,SNR);
        
        sI = real(s);
        sQ = imag(s);
        
        so = getCarrier(f0,t,phi_s);
        soI = real(so);
        soQ = imag(so);
        
        sI = sI.*soI;
        sQ = sQ.*soQ;
        
        
        filt = fir1(34,0.1,'low',chebwin(35,30));
        
        sI = filter(filt,1,sI);
        sQ = filter(filt,1,sQ);
        
        
        s = sI + 1i*sQ;
        
        S = fft(s);
        SI = real(S);
        SQ = imag(S);
        
        code = getCoder(t,dsw,s0,timp,fs);
        t0 = T_standing/2;
        Scode = getFilter(code,fs,t0);
        
        SI = SI.*Scode;
        SQ = SQ.*Scode;
        
        S = SI + 1i*SQ;
        
        signal = ifft(S);
        signalI = fftshift(real(signal));
        signalQ = fftshift(imag(signal));
        [M,idxI] = max(signalI);
        [M,idxQ] = max(signalQ);
        
        tI = (idxI-1)/fs;
        tQ = (idxQ-1)/fs;
        
        
        RI = c*tI/2;
        RQ = c*tQ/2;
        
        R = (RI + RQ)/2;
        
        pI = sum(signalI.^2)/length(signalI);
        pQ = sum(signalQ.^2)/length(signalQ);

        
        p = sqrt(pI^2 + pQ^2);
        if(p>Pmax)
            Pmax = p;
            x = R*cosd(phi0);
            z = R*sind(phi0);
            I = signalI;
            Q = signalQ;
            S_I = fftshift(abs(SI));
            S_Q = fftshift(abs(SQ));
        end
    
end


end