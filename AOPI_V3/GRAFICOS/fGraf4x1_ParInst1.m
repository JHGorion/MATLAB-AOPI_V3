%Función para graficar la señal y sus magnitudes instantáneas
function fGraf4x1_ParInst1(Sx, A_i, Fa_i, Fr_i,figNum)
    %%Grafica
    %1 graficas con la Sx la amplitud, fase, frecuencia instantánea
    %Parametros Internos
    Xfin=length(Sx);
    %
    figure(figNum);%figNum=figNum+1;%Para incrementar el número de la figura
    subplot(4,1,1);
    plot(Sx);
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Amplitud');
    title('a) Señal');
    axis([0.0,Xfin,-1.2,1.2]);
    grid on;
    %
    subplot(4,1,2);
    plot(A_i);% Amplitud instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Amplitud');
    title('b) Amplitud instantánea');
    axis([0.0,Xfin,0,1.2]);
    grid on;
    %
    subplot3=subplot(4,1,3);
    plot(Fa_i);% Fase instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Fase');
    title('c) Fase instantánea');
    axis([0,Xfin,-3.2,3.2]);
    grid on;
    set(subplot3,'YTick',[-3.14 -2 0 2 3.14],'YTickLabel',...
    {'-\pi','-2','0','2','\pi'});
    %
    subplot(4,1,4);
    plot(Fr_i);% Frecuencia instantánea
    %parámetros Figura
    xlabel('Num Muestra');
    ylabel('Frecuencia');
    title('d) Frecuencia instantánea');
    %axis([0,Xfin,0,55]);
    axis([0,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    grid on;
    %
 
end%Funcion fGraf4x1_ParInst1
% JORGE Y. HERNÁNDEZ GARCÍA


