%Funci�n para graficar 'Comparaci�n magnitudes instant�neas Ideales, calculadas y promedio'
function fGraf1G3x2_ParInstCompSxRuidSxProm(Sx,N,A_i,Am_iProm,Fa_i,Fa_iProm,Fr_i,Fr_iProm,AmP_i,FaP_i,FrP_i,figNum)
    %%Grafica
    %1 graficas con la Sx la amplitud, fase, frecuencia instant�nea
    %Par�metros Internos
    Xfin=length(Sx);
    %
    figure(figNum);%figNum=figNum+1;%Para incrementar el n�mero de la figura
    subplot1=subplot(3,2,1);
    plot(N,A_i,N,AmP_i);% Amplitud instant�nea
    %par�metros Figura
    xlabel('Num Muestra');
    ylabel('Amplitud');
    title('a) Amplitud Instant�nea calculada e ideal');
    axis([0.0,Xfin,0,1.2]);
    grid on;
    legend('Am_i(Calc)','Am_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot3=subplot(3,2,3);
    plot(N,Fa_i,N,FaP_i);% Fase instant�nea
    %par�metros Figura
    xlabel('Num Muestra');
    ylabel('Fase');
    title('c) Fase Instant�nea calculada e ideal');
    axis([0,Xfin,-pi,pi]);
    grid on;
    legend('Fa_i(Calc)','Fa_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    set(subplot3,'YTick',[-3.14 -2 0 2 3.14],'YTickLabel',...
    {'-\pi','-2','0','2','\pi'});
    %
    subplot(3,2,5);
    plot(N,Fr_i,N,FrP_i);% Frecuencia instant�nea
    %par�metros Figura
    xlabel('Num Muestra');
    ylabel('Frecuencia');
    title('e) Frecuencia Instant�nea calculada e ideal');
    %axis([0,Xfin,0,55]);
    axis([0,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    grid on;
    legend('Fr_i(Calc)','Fr_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot(3,2,2);
    plot(N,Am_iProm,N,AmP_i);% Amplitud instant�nea
    %par�metros Figura
    xlabel('Num Muestra');
    ylabel('Amplitud');
    title('b) Amplitud Instant�nea calculada promedio e ideal');
    axis([0.0,Xfin,0,inf]);
    grid on;
    legend('Am_i(Calc)','Am_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot4=subplot(3,2,4);
    plot(N,Fa_iProm,N,FaP_i);% Fase instant�nea
    %par�metros Figura
    xlabel('Num Muestra');
    ylabel('Fase');
    title('d) Fase Instant�nea calculada promedio e ideal');
    axis([0,Xfin,-pi,pi]);
    grid on;
    legend('Fa_i(Calc)','Fa_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    set(subplot4,'YTick',[-3.14 -2 0 2 3.14],'YTickLabel',...
    {'-\pi','-2','0','2','\pi'});
    
    %
    subplot(3,2,6);
    plot(N,Fr_iProm,N,FrP_i);% Frecuencia instant�nea
    %par�metros Figura
    xlabel('Num Muestra');
    ylabel('Frecuencia');
    title('f) Frecuencia Instant�nea calculada promedio e ideal');
    %axis([0,Xfin,0,55]);
    axis([0,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    grid on;
    legend('Fr_i(Calc)','Fr_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
 
end%Funcion fGRAFICA_1
% JORGE Y. HERN�NDEZ GARC�A


