function S = getFFT(signal,fs,limits,string)

    S = fft(signal);
%     SI = real(S);
%     SQ = imag(S);
%     SI = fftshift(abs(SI));
%     SQ = fftshift(abs(SQ));
%     step = fs/length(S);
%     f = -fs/2:step:fs/2-step;
%     figure;
%     subplot(2,1,1);
%     plot(f,10*log10(SI));
%     grid on;
%     xlim(limits);
%     title(strcat(string,' (I)'));
%     subplot(2,1,2);
%     plot(f,10*log10(SQ));
%     grid on;
%     xlim(limits);
%     title(strcat(string,' (Q)'));
    

end
