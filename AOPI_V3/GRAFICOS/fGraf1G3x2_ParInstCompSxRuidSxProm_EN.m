%Función para graficar 'Comparación magnitudes instantáneas Ideales, calculadas y promedio' versión en ingles
function fGraf1G3x2_ParInstCompSxRuidSxProm_EN(Sx,N,A_i,Am_iProm,Fa_i,Fa_iProm,Fr_i,Fr_iProm,AmP_i,FaP_i,FrP_i,figNum)
    %%Grafica
    %1 graficas con la Sx la amplitud, fase, frecuencia instantánea
    %Parámetros Internos
    Xfin=length(Sx);
    %
    figure(figNum);%figNum=figNum+1;%Para incrementar el número de la figura
    %subplot1=subplot(3,2,1);
    subplot(3,2,1);
    plot(N,A_i,N,AmP_i);% Amplitud instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Amplitud');
    title('a) Instantaneous amplitude calculated and ideal');
    axis([0.0,Xfin,0,1.2]);
    grid on;
    legend('Am_i(Calc)','Am_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot3=subplot(3,2,3);
    plot(N,Fa_i,N,FaP_i);% Fase instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Fase');
    title('c) Instantaneous fase calculated and ideal');
    axis([0,Xfin,-pi,pi]);
    grid on;
    legend('Fa_i(Calc)','Fa_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    set(subplot3,'YTick',[-3.14 -2 0 2 3.14],'YTickLabel',...
    {'-\pi','-2','0','2','\pi'});
    %
    subplot(3,2,5);
    plot(N,Fr_i,N,FrP_i);% Frecuencia instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Frecuencia');
    title('e) Instantaneous frequency calculated and ideal');
    %axis([0,Xfin,0,55]);
    axis([0,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    grid on;
    legend('Fr_i(Calc)','Fr_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot(3,2,2);
    plot(N,Am_iProm,N,AmP_i);% Amplitud instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Amplitud');
    title('b) Average instantaneous amplitude calculated and ideal');
    axis([0.0,Xfin,0,inf]);
    grid on;
    legend('Am_i(Calc)','Am_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot4=subplot(3,2,4);
    plot(N,Fa_iProm,N,FaP_i);% Fase instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Fase');
    title('d) Average instantaneous fase calculated and ideal');
    axis([0,Xfin,-pi,pi]);
    grid on;
    legend('Fa_i(Calc)','Fa_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');
    set(subplot4,'YTick',[-3.14 -2 0 2 3.14],'YTickLabel',...
    {'-\pi','-2','0','2','\pi'});
    
    %
    subplot(3,2,6);
    plot(N,Fr_iProm,N,FrP_i);% Frecuencia instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Frecuencia');
    title('f) Average instantaneous frequency calculated and ideal');
    %axis([0,Xfin,0,55]);
    axis([0,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    grid on;
    legend('Fr_i(Calc)','Fr_i(ideal)');%,'Location','northeastoutside'
    %legend('boxoff');

end% Función fGraf1G3x2_ParInstCompSxRuidSxProm_EN
% JORGE Y. HERNÁNDEZ GARCÍA


