%Funci�n para graficar los par�metros instant�neos y compararlos con los valores ideales
function fGraf4x1_ParInstComp(Sx,N,A_i,Fa_i,Fr_i,AmP_i,FaP_i,FrP_i,figNum)
    %%Grafica
    %1 graficas con la Sx la amplitud, fase, frecuencia instant�nea
    %Par�metros Internos
    Xfin=length(Sx);
    %
    figure(figNum);%figNum=figNum+1;%Para incrementar el n�mero de la figura
    subplot(2,2,1);
    plot(Sx);
    %par�metros Figura
    xlabel('Num Muestra','FontSize',12);
    ylabel('Amplitud','FontSize',12);
    title('a) Se�al+AWGN','FontSize',12);
    axis([0.0,Xfin,-1.2,1.2]);
    grid on;
    %
    subplot(2,2,2);
    plot(N,A_i,N,AmP_i);% Amplitud instant�nea
    %par�metros Figura
    xlabel('Num Muestra','FontSize',12);
    ylabel('Amplitud','FontSize',12);
    title('b) Amplitud Instant�nea calculada y real','FontSize',12);
    axis([0.0,Xfin,0,1.2]);
    grid on;
    legend('Am_i(Calc)','Am_i(Real)');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot3=subplot(2,2,3);
    plot(N,Fa_i,N,FaP_i);% Fase instant�nea
    %par�metros Figura
    xlabel('Num Muestra','FontSize',12);
    ylabel('Fase','FontSize',12);
    title('c) Fase Instant�nea calculada y real','FontSize',12);
    axis([0,Xfin,-3.2,3.2]);
    grid on;
    legend('Fa_i(Calc)','Fa_i(Real)');%,'Location','northeastoutside'
    %legend('boxoff');
    set(subplot3,'YTick',[-3.14 -2 0 2 3.14],'YTickLabel',...
    {'-\pi','-2','0','2','\pi'});
    %
    subplot(2,2,4);
    plot(N,Fr_i,N,FrP_i);% Frecuencia instant�nea
    %par�metros Figura
    xlabel('Num Muestra','FontSize',12);
    ylabel('Frecuencia','FontSize',12);
    title('d) Frecuencia Instant�nea calculada y real','FontSize',12);
    %axis([0,Xfin,0,55]);
    axis([0,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    grid on;
    legend('Fr_i(Calc)','Fr_i(Real)');%,'Location','northeastoutside'
    %legend('boxoff');
    %
 
end% Funci�n fGraf4x1_ParInstComp
% JORGE Y. HERN�NDEZ GARC�A


