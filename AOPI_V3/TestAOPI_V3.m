%Scrip para la generación de señales y determinación de sus magnitudes instantáneas.
clear variables;
clear functions;
%PARÁMETROS
fs=2e3;
Ts=1/fs;
fy =20; %Frecuencia de la señal a generar
snr=30; %Relación señal a ruido para la señal
%ADICIONAR CARPETAS TEMPORALES
addpath('Sx','bASx','bOPI','bDIE\mOPE','GRAFICOS');% Adiciona la carpeta en los path de MATLAB para ejecutar la función en su interior
 
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
TipSx=1;% selecciones el tipo de señal
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

%*******************************************************************************************

%%GRÁFICAS
figNum=1;%figNum = figNum+1;%Para incrementar el número de la figura
fGrafSxEspGram_1(Sx_n,N,fs,figNum);figNum = figNum+1;%Para incrementar el número de la figura
fGrafFFT_1(Sx_n,fs,figNum);figNum = figNum+1;%Para incrementar el número de la figura
fGraf4x1_ParInst1(Sx_n,A_i, Fa_i, Fr_i,figNum);figNum = figNum+1;%Para incrementar el número de la figura
fGraf1G3x2_ParInstCompSxRuidSxProm(Sx_n,N,A_i,Am_iProm,Fa_i,Fa_iProm,Fr_i,Fr_iProm,AmP_i,FaP_i,FrP_i,figNum);figNum = figNum+1;%Para incrementar el numero de la figura
% %
rmpath('Sx','bASx','bOPI','bDIE\mOPE','GRAFICOS');% Elimina la carpeta en los path de MATLAB
% JORGE Y. HERNÁNDEZ GARCÍA

