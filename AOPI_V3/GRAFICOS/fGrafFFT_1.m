%Funci�n para graficar se�al con FFT
%(Sx Se�al
%)
function fGrafFFT_1(Sx,fs,figNum)
    %Xfin=length(Sx);
    Sxfft=fft(Sx,1024);
    L=length(Sxfft);
    P2 = abs(Sxfft/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = fs*(0:(L/2))/L;
    
    figure(figNum); %figNum = figNum+1;%Para incrementar el n�mero de la figura
    plot(f,P1) 
    title('Espectro unilateral de la se�al','FontSize',12);
    xlabel('f (Hz)','FontSize',12);
    ylabel('|P1(f)|','FontSize',12);
    grid on;
    %
end% Funci�n fGrafFFT_1
%JORGE Y. HERN�NDEZ GARC�A