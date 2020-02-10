%Scrip para la comprobar los errores en la determinaci�n de las magnitudes instant�neas. Se realiza L_snr=length(snrVec)iteraciones para el c�lculo de la amplitud y L_snr=length(snrVec) x L_fr=length(FsVec)iteraciones para el c�lculo de la frecuencia

clear variables;
clear functions;
%PAR�METROS
fs=2e3;
Ts=1/fs;
fy =20; %Frecuencia de la se�al a generar
snr=30; %Relaci�n se�al a ruido para la se�al
%ADICIONAR CARPETAS TEMPORALES
addpath('Sx','bASx','bOPI','bDIE','bDIE\mOPE','GRAFICOS');% Adiciona la carpeta en los path de MATLAB para ejecutar la funci�n en su interior
 
%%INICIO CICLO PARA EVALUACI�N DE COMPORTAMIENTO ALGORITMO
snrVec=-10:1:70;%Vector con los valores de SNR. En pruebas para valores mayores de 50 los errores son constantes
% snrVec= 20;
L_snr=length(snrVec);
 
%Almacena los errores en el calculo de la TOTAL (para todos los valores snr)
rErrAm_Tot = zeros(1,L_snr);% errores amplitud 
rErrFr_Tot = zeros(1,L_snr);%errores Frecuencia
%Errores normalizados en porciento respecto al real (abs((Err*100)/mean(ValReal))) 
rErrAm_TotNorm = zeros(1,L_snr);% errores amplitud 
rErrFr_TotNorm = zeros(1,L_snr);%errores Frecuencia
 
%Para evaluar el error de frecuencia con variaci�n frecuencia de muestreo
 
FsVec= [0.3e3 0.4e3 0.5e3 0.6e3 0.8e3 1e3 2e3 3e3 4e3 5e3];% para ajustar los valores de fs/fy
% FsVec= 4e3;
L_fr=length(FsVec);
%
mErrFr_TotNorm = zeros(L_snr,L_fr);%matrix de (L_snr Filas y L_fr columnas) con errores frecuencia evaluados para distintos SNR y frecuencias de muestreo
mErrFr_Tot = zeros(L_snr,L_fr);
 
% CICLO PARA EVALUAR LOS ERRORES DE CALCULO FRECUENCIA SEG�N FRECUENCIA DE
% MUESTREO
for k_fr = 1:L_fr
    %Para evaluar el error de frecuencia con variaci�n frecuencia portadora
    % fy=FrVec(k_fr);
    %
    %Para evaluar el error de frecuencia con variaci�n frecuencia de muestreo
    fs=FsVec(k_fr);
    Ts=1/fs;
    fy=100;
    %
    %CICLO PARA EVALUACI�N DE COMPORTAMIENTO ALGORITMO OPI
    for k_snr = 1:L_snr 
        snr=snrVec(k_snr);
 
        %%********************* GENERADOR DE SE�ALES DE PRUEBA
        % 1 % Se�al de FHSS; 
        % 2 % Se�al LFM con control del ancho de banda 
        % 3 % Se�al DSSS
        % 4 % Se�al Pulso CW
        % 5 % Se�al BPSK
        % 6 % Se�al CW Coseno
        % 7 % Se�al CW Seno
        % 8 % Se�al DSSS Pulso
        % 9 % Se�al de FHSS continua; 
        % otherwise %Se�al VCO Frecuencia variable
        TipSx=4;% selecciones el tipo de se�al
        Ruid=1;% Si es 1 adiciona ruido a la se�al con valor de snr, 0 sin ruido
 
        [Sx_n,Mod,AmP_i,FaP_i,FrP_i] = fTestGenSx(TipSx,fy,fs,Ruid,snr);% (Tipo Se�al, frecuencia, frecuencia muestreo, Habilita Ruido, relaci�n se�al ruido  
 
        %%********************* BLOQUE DE ACONDICIONAMIENTO DE SE�ALES 
 
        %Obtenci�n de IQ de la se�al generada
        [Sh,I,Q]=fOptIQ(Sx_n);
 
        %%********************* BLOQUE DE OBTENCI�N DE PAR�METROS INSTANT�NEOS 
        [N,A_i,Fa_i,Fr_i] = fOPI(Sh,Ts,I,Q);
 
        %******CALCULO DE PAR�METROS ESTAD�STICOS
        %PAR�METROS
        %AMPLITUD INSTANT�NEA 
        % C�lculo estad�stico con ventana deslizante 
        k_AiPro=30;%longitud ventana promedio Ai % Para [movmean(A,k)] Cada promedio se calcula sobre una ventana deslizante de longitud k 
        [Am_iProm] = fFiltProm_VD(A_i,k_AiPro,1);% [Am_iProm] = fEstVentDes_Am(A_i,k_AiPro);
 
        %FASE INSTANT�NEA 
        % C�lculo estad�stico con ventana deslizante 
        k_FaiPro=3;%longitud ventana promedio Fa_i
        [Fa_iProm] = fFiltProm_VD(Fa_i,k_FaiPro,1);
 
        %FRECUENCIA INSTANT�NEA
        % C�lculo estad�stico con ventana deslizante 
        k_FriPro=27;%longitud ventana promedio Fr_i
        [Fr_iProm] = fFiltProm_VD(Fr_i,k_FriPro,1);
        % 
       
        %*********Calculo del comportamiento temporal, de amplitud y frecuencia IDEALES de la se�al para comparaci�n
        PreSx=AmP_i; %Se realiza esta asignaci�n temporalmente para garantizar detecci�n con ruido para calcular los errores en determinaci�n de los PI 
        %PreSxIdeal=AmP_i; % Se le asigna el valor de AmP_i que representa el comportamiento temporal de la se�al sin ruido
        
        %Valor de guarda para el calculo
        ParAmi=Am_iProm;
        GuardParAmi=k_AiPro;%Valor de guarda para el c�lculo, no se tienen en cuental los (GuerdPar1) valores  del inicio y del final
        
        ParFri=Fr_iProm;%Par�metro que se filtra seleccionando solo los valores de los
        GuardParFri=k_FriPro;%Valor de guarda para el c�lculo, no se tienen en cuental los (GuerdPar1) valores  del inicio y del final
        
        GuardParAmiIdeal=k_AiPro;
        GuardParFriIdeal=k_FriPro;
        
        %Funci�n para el c�lculo de los errores en la determinaci�n de las magnitudes instant�neas
        [rTPulSxHi,rTPulSxLo,CantPuls,rParAmi_DetProm,rParFri_DetProm,rTPulSxHiIdeal,rTPulSxLoIdeal,CantPulsIdeal,rParAmiIdeal_DetProm,rParFriIdeal_DetProm] = fDelimParCalcEstadCompIdeal(ParFri,GuardParFri,ParAmi,GuardParAmi,PreSx,N,AmP_i,FrP_i,GuardParAmiIdeal,GuardParFriIdeal);
        
        
        %*** AN�LISIS DE LOS ERRORES DE CALCULO PARA DISTINTOS SNR
        %Almacena los errores en el c�lculo de la Iteraci�n (para cada valor snr)
        rErrAm_IterSNR = zeros(1,CantPuls);% errores amplitud 
        rErrFr_IterSNR = zeros(1,CantPuls);%errores Frecuencia
 
        %Calculo de la diferencia del promedio de los valores de la magnitud para cada pulso entre (real - ideal)
        rErrAm_IterSNR=rParAmi_DetProm-rParAmiIdeal_DetProm;
        rErrFr_IterSNR=rParFri_DetProm-rParFriIdeal_DetProm;
 
        %Determinar los promedios de los errores en cada iteraci�n de SNR
        ErrAm_IterProm=mean(rErrAm_IterSNR);
        ErrFr_IterProm=mean(rErrFr_IterSNR);
 
        %Promedio de los N errores (N= Cantidad de pulsos) para cada valor de SNR
        rErrAm_Tot(k_snr)=ErrAm_IterProm;% errores amplitud 
        rErrFr_Tot(k_snr)=ErrFr_IterProm;%errores Frecuencia
 
        %Normalizaci�n de las variables
        %Se calcula el porciento que representa el error respecto al valor real 
        rErrAm_TotNorm(k_snr)=abs((ErrAm_IterProm*100)/mean(rParAmiIdeal_DetProm));% errores amplitud 
        rErrFr_TotNorm(k_snr)=abs((ErrFr_IterProm*100)/mean(rParFriIdeal_DetProm));%errores Frecuencia    
        %************** FIN ****AN�LISIS DE LOS ERRORES DE CALCULO PARA DISTINTOS SNR******************
    end %(for k_snr = 1:L_snr) CICLO PARA EVALUACI�N DE COMPORTAMIENTO ALGORITMO OPI    
    
    %*** AN�LISIS DE LOS ERRORES DE CALCULO PARA DISTINTAS Fs
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
    %*************** FIN *****AN�LISIS DE LOS ERRORES DE CALCULO PARA DISTINTAS Fs*****************
 
end % (for k_fr = 1:L_fr) CICLO PARA EVALUAR LOS ERRORES DE CALCULO FRECUENCIA SEG�N FRECUENCIA DE
% MUESTREO
    
    
    
    
%*******************************************************************************************
 
%%GR�FICAS
figNum=1;%figNum = figNum+1;%Para incrementar el n�mero de la figura
fGraf_ErrAmpFrecNormAnaFsNomLeyend(snrVec,rErrAm_TotNormFs,mErrFr_TotNorm,figNum,FsVec,fy);figNum = figNum+1;%Para incrementar el n�mero de la figura
% %
rmpath('Sx','bASx','bOPI','bDIE','bDIE\mOPE','GRAFICOS');% Elimina la carpeta en los path de MATLAB
% JORGE Y. HERN�NDEZ GARC�A
