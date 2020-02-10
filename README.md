# MATLAB-AOPI_V3
 Código MATLAB para comprobar el algoritmo de obtención de las magnitudes instantáneas a partir de generación señales patrón FHSS,Pulso CW, con concontrol de SNR

 # Comprobar el algoritmo de obtención de las magnitudes instantáneas a partir de generación señales patrón FHSS,Pulso CW, con concontrol de SNR

Se emplea como generador parón para comprobar sistemas de comunicaciones y su desempeño para distintas SNR.
Para comprobar algoritmos para determinación de magnitudes instantáneas. Un ejemplo descrito lo puede encontrar en el artículo en PDF URL:
									 																																										
	EN ESPAÑOL																																																			
https://www.researchgate.net/publication/338633516_Determinacion_de_las_caracteristicas_instantaneas_de_senales_para_aplicaciones_de_tiempo_real_en_radio_cognitivo
																														
	IN ENGLISH
https://www.researchgate.net/publication/338901999_Determination_of_instantaneous_features_of_signals_for_real-time_applications_in_cognitive_radio 

	AOPI_V3 %Directorio básico.
	AOPI_V3\Sx %Contiene las funciones de generación de señales
	AOPI_V3\GRAFICOS %Contiene las funciones para graficar.
	AOPI_V3\bASx %Contiene la función para obtener los vectores I y Q de la señal generada
	AOPI_V3\bOPI %Contiene las funciones para obtener las magnitudes instantáneas
	AOPI_V3\bDIE %Contiene la función para determinar los errores de amplitud y frecuencia para distintos SNR teniendo como referencia los valores ideales
	AOPI_V3\bDIE\mOPE %Contiene la función para el promedio con ventana deslizante
	AOPI_V3\TestAOPI_V3.m
	Es el SCRIPT principal desde el cual se llaman a las funciones de generación de señales y gráficos
	Las señales que se pueden generar son:
                                       
    GENERADOR DE SEÑALES DE PRUEBA
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


	AOPI_V3\TestAOPI_V3CicloForV2.m
% SCRIPT para determinar los errores en la obtención de amplitud y fase.
	
	Código distribuido bajo licencia ECR (Emplee, Contribuya y Reconozca)
	Code distributed under ECR license (Employ, Contribute and Recognize)
	Copyright (c) 2020 Jorge Y. Hernández García

https://www.researchgate.net/profile/Jorge_Y_Garcia

                                                
                                                ENGLISH
MATLAB codes to check the algorithm for obtaining the instantaneous magnitudes
	You can be found in the article in PDF URL:
									 																																										
	EN ESPAÑOL																																																			
https://www.researchgate.net/publication/338633516_Determinacion_de_las_caracteristicas_instantaneas_de_senales_para_aplicaciones_de_tiempo_real_en_radio_cognitivo
																														
	IN ENGLISH
https://www.researchgate.net/publication/338901999_Determination_of_instantaneous_features_of_signals_for_real-time_applications_in_cognitive_radio 

	AOPI_V3 %Basic Directory
	AOPI_V3\Sx %Contains signal generation functions
	AOPI_V3\GRAFICOS %It contains the functions to graph.
	AOPI_V3\bASx %Contains the function to obtain vectors I and Q of the generated signal
	AOPI_V3\bOPI %It contains the functions to obtain the instantaneous magnitudes
	AOPI_V3\bDIE %It contains the function to determine the amplitude and frequency errors for different SNRs having as reference the ideal values

	AOPI_V3\bDIE\mOPE %Contains the function for the average with sliding window    
	AOPI_V3\TestAOPI_V3.m
	SCRIPT to obtain the instantaneous magnitudes and graph them. the time generated signal, spectrogram and its FFT are also plotted.
	Different signals can be selected such as:
                                       
    TEST SIGNAL GENERATOR
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


	AOPI_V3\TestAOPI_V3CicloForV2.m
	%SCRIPT to determine errors in obtaining amplitude and phase.
	
	Código distribuido bajo licencia ECR (Emplee, Contribuya y Reconozca)
	Code distributed under ECR license (Employ, Contribute and Recognize)
	Copyright (c) 2020 Jorge Y. Hernández García

https://www.researchgate.net/profile/Jorge_Y_Garcia