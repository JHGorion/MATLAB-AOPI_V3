%Scrip para la comprobar los errores en la determinación de las magnitudes instantáneas. Se realiza L_snr=length(snrVec)iteraciones para el cálculo de la amplitud y L_snr=length(snrVec) x L_fr=length(FsVec)iteraciones para el cálculo de la frecuencia

clear variables;
clear functions;
%PARÁMETROS
fs=2e3;
Ts=1/fs;
fy =20; %Frecuencia de la señal a generar
snr=30; %Relación señal a ruido para la señal
%ADICIONAR CARPETAS TEMPORALES
addpath('Sx','bASx','bOPI','bDIE','bDIE\mOPE','GRAFICOS');% Adiciona la carpeta en los path de MATLAB para ejecutar la función en su interior
 
%%INICIO CICLO PARA EVALUACIÓN DE COMPORTAMIENTO ALGORITMO
snrVec=-10:1:70;%Vector con los valores de SNR. En pruebas para valores mayores de 50 los errores son constantes
% snrVec= 20;
L_snr=length(snrVec);
 
%Almacena los errores en el calculo de la TOTAL (para todos los valores snr)
rErrAm_Tot = zeros(1,L_snr);% errores amplitud 
rErrFr_Tot = zeros(1,L_snr);%errores Frecuencia
%Errores normalizados en porciento respecto al real (abs((Err*100)/mean(ValReal))) 
rErrAm_TotNorm = zeros(1,L_snr);% errores amplitud 
rErrFr_TotNorm = zeros(1,L_snr);%errores Frecuencia
 
%Para evaluar el error de frecuencia con variación frecuencia de muestreo
 
FsVec= [0.3e3 0.4e3 0.5e3 0.6e3 0.8e3 1e3 2e3 3e3 4e3 5e3];% para ajustar los valores de fs/fy
% FsVec= 4e3;
L_fr=length(FsVec);
%
mErrFr_TotNorm = zeros(L_snr,L_fr);%matrix de (L_snr Filas y L_fr columnas) con errores frecuencia evaluados para distintos SNR y frecuencias de muestreo
mErrFr_Tot = zeros(L_snr,L_fr);
 
% CICLO PARA EVALUAR LOS ERRORES DE CALCULO FRECUENCIA SEGÚN FRECUENCIA DE
% MUESTREO
for k_fr = 1:L_fr
    %Para evaluar el error de frecuencia con variación frecuencia portadora
    % fy=FrVec(k_fr);
    %
    %Para evaluar el error de frecuencia con variación frecuencia de muestreo
    fs=FsVec(k_fr);
    Ts=1/fs;
    fy=100;
    %
    %CICLO PARA EVALUACIÓN DE COMPORTAMIENTO ALGORITMO OPI
    for k_snr = 1:L_snr 
        snr=snrVec(k_snr);
 
        %%********************* GENERADOR DE SEÑALES DE PRUEBA
        % 1 % Señal de FHSS; 
        % 2 % Señal LFM con control del ancho de banda 
        % 3 % Señal DSSS
        % 4 % Señal Pulso CW
        % 5 % Señal BPSK
        % 6 % Señal CW Coseno
        % 7 % Señal CW Seno
        % 8 % Señal DSSS Pulso
        % 9 % Señal de FHSS continua; 
        % otherwise %Señal VCO Frecuencia variable
        TipSx=4;% selecciones el tipo de señal
        Ruid=1;% Si es 1 adiciona ruido a la señal con valor de snr, 0 sin ruido
 
        [Sx_n,Mod,AmP_i,FaP_i,FrP_i] = fTestGenSx(TipSx,fy,fs,Ruid,snr);% (Tipo Señal, frecuencia, frecuencia muestreo, Habilita Ruido, relación señal ruido  
 
        %%********************* BLOQUE DE ACONDICIONAMIENTO DE SEÑALES 
 
        %Obtención de IQ de la señal generada
        [Sh,I,Q]=fOptIQ(Sx_n);
 
        %%********************* BLOQUE DE OBTENCIÓN DE PARÁMETROS INSTANTÁNEOS 
        [N,A_i,Fa_i,Fr_i] = fOPI(Sh,Ts,I,Q);
 
        %******CALCULO DE PARÁMETROS ESTADÍSTICOS
        %PARÁMETROS
        %AMPLITUD INSTANTÁNEA 
        % Cálculo estadístico con ventana deslizante 
        k_AiPro=30;%longitud ventana promedio Ai % Para [movmean(A,k)] Cada promedio se calcula sobre una ventana deslizante de longitud k 
        [Am_iProm] = fFiltProm_VD(A_i,k_AiPro,1);% [Am_iProm] = fEstVentDes_Am(A_i,k_AiPro);
 
        %FASE INSTANTÁNEA 
        % Cálculo estadístico con ventana deslizante 
        k_FaiPro=3;%longitud ventana promedio Fa_i
        [Fa_iProm] = fFiltProm_VD(Fa_i,k_FaiPro,1);
 
        %FRECUENCIA INSTANTÁNEA
        % Cálculo estadístico con ventana deslizante 
        k_FriPro=27;%longitud ventana promedio Fr_i
        [Fr_iProm] = fFiltProm_VD(Fr_i,k_FriPro,1);
        % 
       
        %*********Calculo del comportamiento temporal, de amplitud y frecuencia IDEALES de la señal para comparación
        PreSx=AmP_i; %Se realiza esta asignación temporalmente para garantizar detección con ruido para calcular los errores en determinación de los PI 
        %PreSxIdeal=AmP_i; % Se le asigna el valor de AmP_i que representa el comportamiento temporal de la señal sin ruido
        
        %Valor de guarda para el calculo
        ParAmi=Am_iProm;
        GuardParAmi=k_AiPro;%Valor de guarda para el cálculo, no se tienen en cuental los (GuerdPar1) valores  del inicio y del final
        
        ParFri=Fr_iProm;%Parámetro que se filtra seleccionando solo los valores de los
        GuardParFri=k_FriPro;%Valor de guarda para el cálculo, no se tienen en cuental los (GuerdPar1) valores  del inicio y del final
        
        GuardParAmiIdeal=k_AiPro;
        GuardParFriIdeal=k_FriPro;
        
        %Función para el cálculo de los errores en la determinación de las magnitudes instantáneas
        [rTPulSxHi,rTPulSxLo,CantPuls,rParAmi_DetProm,rParFri_DetProm,rTPulSxHiIdeal,rTPulSxLoIdeal,CantPulsIdeal,rParAmiIdeal_DetProm,rParFriIdeal_DetProm] = fDelimParCalcEstadCompIdeal(ParFri,GuardParFri,ParAmi,GuardParAmi,PreSx,N,AmP_i,FrP_i,GuardParAmiIdeal,GuardParFriIdeal);
        
        
        %*** ANÁLISIS DE LOS ERRORES DE CALCULO PARA DISTINTOS SNR
        %Almacena los errores en el cálculo de la Iteración (para cada valor snr)
        rErrAm_IterSNR = zeros(1,CantPuls);% errores amplitud 
        rErrFr_IterSNR = zeros(1,CantPuls);%errores Frecuencia
 
        %Calculo de la diferencia del promedio de los valores de la magnitud para cada pulso entre (real - ideal)
        rErrAm_IterSNR=rParAmi_DetProm-rParAmiIdeal_DetProm;
        rErrFr_IterSNR=rParFri_DetProm-rParFriIdeal_DetProm;
 
        %Determinar los promedios de los errores en cada iteración de SNR
        ErrAm_IterProm=mean(rErrAm_IterSNR);
        ErrFr_IterProm=mean(rErrFr_IterSNR);
 
        %Promedio de los N errores (N= Cantidad de pulsos) para cada valor de SNR
        rErrAm_Tot(k_snr)=ErrAm_IterProm;% errores amplitud 
        rErrFr_Tot(k_snr)=ErrFr_IterProm;%errores Frecuencia
 
        %Normalización de las variables
        %Se calcula el porciento que representa el error respecto al valor real 
        rErrAm_TotNorm(k_snr)=abs((ErrAm_IterProm*100)/mean(rParAmiIdeal_DetProm));% errores amplitud 
        rErrFr_TotNorm(k_snr)=abs((ErrFr_IterProm*100)/mean(rParFriIdeal_DetProm));%errores Frecuencia    
        %************** FIN ****ANÁLISIS DE LOS ERRORES DE CALCULO PARA DISTINTOS SNR******************
    end %(for k_snr = 1:L_snr) CICLO PARA EVALUACIÓN DE COMPORTAMIENTO ALGORITMO OPI    
    
    %*** ANÁLISIS DE LOS ERRORES DE CALCULO PARA DISTINTAS Fs
    %Frecuencia
    rErrFrTranp_Tot=rErrFr_Tot';
    mErrFr_Tot(:,k_fr) = rErrFrTranp_Tot;
    %Normalizados
    rErrFrTranp_TotNorm = rErrFr_TotNorm';
    mErrFr_TotNorm(:,k_fr) = rErrFrTranp_TotNorm;
    
    %Amplitud
    %Normalizados
    mErrAm_TotNorm(k_fr,:) = rErrAm_TotNorm;
    rErrAm_TotNormFs=mean(mErrAm_TotNorm);% Vector con promedio de los errores de amplitud en cada SNR de todas las iteraciones del for de fs 
    %*************** FIN *****ANÁLISIS DE LOS ERRORES DE CALCULO PARA DISTINTAS Fs*****************
 
end % (for k_fr = 1:L_fr) CICLO PARA EVALUAR LOS ERRORES DE CALCULO FRECUENCIA SEGÚN FRECUENCIA DE
% MUESTREO
    
    
    
    
%*******************************************************************************************
 
%%GRÁFICAS
figNum=1;%figNum = figNum+1;%Para incrementar el número de la figura
fGraf_ErrAmpFrecNormAnaFsNomLeyend(snrVec,rErrAm_TotNormFs,mErrFr_TotNorm,figNum,FsVec,fy);figNum = figNum+1;%Para incrementar el número de la figura
% %
rmpath('Sx','bASx','bOPI','bDIE','bDIE\mOPE','GRAFICOS');% Elimina la carpeta en los path de MATLAB
% JORGE Y. HERNÁNDEZ GARCÍA
