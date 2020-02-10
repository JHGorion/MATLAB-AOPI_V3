%Scrip para la generaci�n de se�ales y determinaci�n de sus magnitudes instant�neas.
clear variables;
clear functions;
%PAR�METROS
fs=2e3;
Ts=1/fs;
fy =20; %Frecuencia de la se�al a generar
snr=30; %Relaci�n se�al a ruido para la se�al
%ADICIONAR CARPETAS TEMPORALES
addpath('Sx','bASx','bOPI','bDIE\mOPE','GRAFICOS');% Adiciona la carpeta en los path de MATLAB para ejecutar la funci�n en su interior
 
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
TipSx=1;% selecciones el tipo de se�al
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

%*******************************************************************************************

%%GR�FICAS
figNum=1;%figNum = figNum+1;%Para incrementar el n�mero de la figura
fGrafSxEspGram_1(Sx_n,N,fs,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura
fGrafFFT_1(Sx_n,fs,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura
fGraf4x1_ParInst1(Sx_n,A_i, Fa_i, Fr_i,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura
fGraf1G3x2_ParInstCompSxRuidSxProm(Sx_n,N,A_i,Am_iProm,Fa_i,Fa_iProm,Fr_i,Fr_iProm,AmP_i,FaP_i,FrP_i,figNum);figNum = figNum+1;%Para incrementar el numero de la figura
% %
rmpath('Sx','bASx','bOPI','bDIE\mOPE','GRAFICOS');% Elimina la carpeta en los path de MATLAB
% JORGE Y. HERN�NDEZ GARC�A

