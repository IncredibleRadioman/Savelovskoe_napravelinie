function K = getFilter(signal,fs,t0)


    S = fft(signal);
    step = fs/length(S);
    freq = -fs/2:step:fs/2-step;
    K = conj(S).*exp(-1i*2*pi*freq*t0);
    

end