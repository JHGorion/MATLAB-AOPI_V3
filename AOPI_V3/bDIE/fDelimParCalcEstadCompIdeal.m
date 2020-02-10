%Función. Selecciona los valores de los parámetros de entrada y coloca solo en la salida los valores en los índices donde PreSx toma valor igual a 1
%Calcula estadisticos de los parámetros reale e ideales para comparación
function [rTPulSxHi,rTPulSxLo,CantPuls,rParAmi_DetProm,rParFri_DetProm,rTPulSxHiIdeal,rTPulSxLoIdeal,CantPulsIdeal,rParAmiIdeal_DetProm,rParFriIdeal_DetProm] = fDelimParCalcEstadCompIdeal(ParFri,GuardParFri,ParAmi,GuardParAmi,PreSx,N,AmP_i,FrP_i,GuardParAmiIdeal,GuardParFriIdeal)
    %**** Inicialización de variables y registros
        LN=length(N);%Determina el número de elementos de N para sincronismo se usa N 
        
        %***Parámetros temporales******
        TinSxHi=0;%Almacena temporalmente el índice de N para indicar el inicio de una sx en alto
        TfinSxHi=0;%Almacena temporalmente el índice de N para indicar el fin de una sx en alto
        TinSxLo=0;%Almacena temporalmente el índice de N para indicar el inicio de una sx en bajo
        TfinSxLo=0;%Almacena temporalmente el índice de N para indicar el fin de una sx en bajo
        rTPulSxHi=[];%Como no se conoce la dimensión se crea un vector vacio
        rTPulSxLo=[];%Como no se conoce la dimensión se crea un vector vacio
        CantPuls=0;%Se incrementa con casa pulso de la señal en alto
                      
        %**Amplitud Instantánea PARÁMETROS
        rParAmi_Det=zeros(1,LN);% Registro que almacena los valores de la amplitud instantánea promedio detectada
        rParAmi_DetProm=[];%Vector con los promedios de los valores mientras que hay presencia de señal
        rParAmi_DetMin=[];%Vector con los valores mínimos por cada detección de presencia de señal
        rParAmi_DetMax=[];%Vector con los valores máximos por cada detección de presencia de señal
        rParAmi_DetDelta=[];%Vector con la diferencia entre los valores máximos y mínimos por cada detección de presencia de señal
                
        %**Frecuencia Instantánea PARÁMETROS
        rParFri_Det=zeros(1,LN);% Registro que almacena los valores De la frecuencia instantánea promedio detectada
        rParFri_DetProm=[];%Vector con los promedios de los valores mientras que hay presencia de señal
        rParFri_DetMin=[];%Vector con los valores mínimos por cada detección de presencia de señal
        rParFri_DetMax=[];%Vector con los valores máximos por cada detección de presencia de señal
        rParFri_DetDelta=[];%Vector con la diferencia entre los valores máximos y mínimos por cada detección de presencia de señal
        
        %*******TEMPORAL Para comparación entre los valores calculados y reales
        rParAmiIdeal_Det=zeros(1,LN);
        rParAmiIdeal_DetProm=[];%Vector con los promedios de los valores reales de la amplitud de la señal
        rParFriIdeal_Det=zeros(1,LN);
        rParFriIdeal_DetProm=[];%Vector con los promedios de los valores reales de la frecuencia de la señal
        rTPulSxHiIdeal=[];%Como no se conoce la dimensión se crea un vector vacío
        rTPulSxLoIdeal=[];%Como no se conoce la dimensión se crea un vector vacío
        CantPulsIdeal=0;%Se incrementa con casa pulso de la señal en alto 
        %*******
        
            
        for n=1:LN
            if(PreSx(n)>=1)%Si Hay detección de señal
                %Se selecciona solo los valores de los parámetros en los índices que PreSx>=1 
                rParAmi_Det(n)=ParAmi(n);
                rParFri_Det(n)=ParFri(n);
                %*******TEMPORAL Para comparación entre los valores calculados y reales
                rParAmiIdeal_Det(n)=AmP_i(n);
                rParFriIdeal_Det(n)=FrP_i(n);
                %********    
                %Medición de la duración de la señal
                if (TinSxHi==0)
                    TinSxHi=n;%Almacena el valor del índice que indica el inicio señal en alto
                    %           
                end
                %Medición de la duración de la señal en bajo
                if (TinSxLo>0)
                    TfinSxLo=n-1;%Almacena el valor del índice que indica el fin de señal en bajo
                    TLo=TfinSxLo-TinSxLo;
                    if(TLo>1)%para descartar los valores igual a 0
                        rTPulSxLo(CantPuls)=TLo;
                        %*******TEMPORAL Para comparación entre los valores calculados y reales
                        rTPulSxLoIdeal(CantPulsIdeal)=TLo;
                        %********
                    end
                    TinSxLo=0;
                end
            %Fin de Medición de la duración de la señal
            else % (SxMedDur(n)>0)
                %Se pone en 0 los intervalos de tiempo donde no se detecta Sx
                rParAmi_Det(n)=0;
                rParFri_Det(n)=0;
                %*******TEMPORAL Para comparación entre los valores calculados y reales
                rParAmiIdeal_Det(n)=0;
                rParFriIdeal_Det(n)=0;
                %********
                %
                %Medición de la duración de la señal
                if (TinSxLo==0)
                    TinSxLo=n;%Almacena el primer valor
                end  
                %Medición de la duración de la señal en alto    
                if (TinSxHi>0)
                    TfinSxHi=n-1;%Almacena el ultimo valor
                    THi=TfinSxHi-TinSxHi;%Calcula la duración de pulso
                    if(THi>1)%para descartar los valores igual a 0
                        CantPuls=CantPuls+1;%Incrementa la cantidad de pulsos (para señales pulsivas)
                        rTPulSxHi(CantPuls)=THi;%Almacena el valor de duración de pulso en el arreglo
                        %*******TEMPORAL Para comparación entre los valores calculados y reales
                        CantPulsIdeal=CantPulsIdeal+1;%Incrementa la cantidad de pulsos (para señales pulsivas)
                        rTPulSxHiIdeal(CantPulsIdeal)=THi;%Almacena el valor de duración de pulso en el arreglo
                        %********
                    end
                    %
                    %Caracterización de los parámetros intra pulsos
                    %Amplitud
                    RangParAmi=(TinSxHi+GuardParAmi):(TfinSxHi-GuardParAmi);%Rango de selección de valores del parámetro 1
                    rParAmi_DetProm(CantPuls)= mean(rParAmi_Det(RangParAmi));%Calcula Promedio de los valores entre dos índices 
                    rParAmi_DetMin(CantPuls)= min(rParAmi_Det(RangParAmi));%Vector con los valores mínimos por cada detección de presencia de señal
                    rParAmi_DetMax(CantPuls)= max(rParAmi_Det(RangParAmi));%Vector con los valores máximos por cada detección de presencia de señal
                    rParAmi_DetDelta(CantPuls)=rParAmi_DetMax(CantPuls)-rParAmi_DetMin(CantPuls);%Vector con la diferencia entre los valores maximos y mínimos por cada detección de presencia de señal
                    %
                    %Frecuencia
                    RangParFri=(TinSxHi+GuardParFri):(TfinSxHi-GuardParFri);%Rango de selección de valores del parámetro 1
                    rParFri_DetProm(CantPuls)= mean(rParFri_Det(RangParFri));%Calcula Promedio de los valores entre dos índices 
                    rParFri_DetMin(CantPuls)= min(rParFri_Det(RangParFri));%Vector con los valores mínimos por cada detección de presencia de señal
                    rParFri_DetMax(CantPuls)= max(rParFri_Det(RangParFri));%Vector con los valores máximos por cada detección de presencia de señal
                    rParFri_DetDelta(CantPuls)=rParFri_DetMax(CantPuls)-rParFri_DetMin(CantPuls);%Vector con la diferencia entre los valores máximos y mínimos por cada detección de presencia de señal
                    %
                    %*******TEMPORAL Para comparación entre los valores calculados y reales
                    RangParAmi=(TinSxHi+GuardParAmiIdeal):(TfinSxHi-GuardParAmiIdeal);%Rango de selecci'on de valores de amplitud ideal
                    RangParFri=(TinSxHi+GuardParFriIdeal):(TfinSxHi-GuardParFriIdeal);%Rango de selecci'on de valores del frecuencia ideal
                    rParAmiIdeal_DetProm(CantPulsIdeal)= mean(rParAmiIdeal_Det(RangParAmi));
                    rParFriIdeal_DetProm(CantPulsIdeal)= mean(rParFriIdeal_Det(RangParFri));
                    %******

                    TinSxHi=0; % inicialización de la variable
                end
                %Fin de Medición de la duración de la señal
          
            end
            if(n==LN)% Resumir las características de la señal
                %Caracterización de la señal
                if (TinSxHi>=1 && TfinSxHi==0)%Para comprobar si se trata de una señal continua
                   rTPulSxHi(1)=LN;
                   rTPulSxLo(1)=0;
                    %*******TEMPORAL Para comparación entre los valores calculados y reales
                   rTPulSxHiIdeal(1)=LN;
                   rTPulSxLoIdeal(1)=0;
                   %******
                end
                %Para medir la ultima pausa.Agregado para ajustar cantidad de valores respecto a valores ideales
                if (TfinSxHi<LN && TfinSxHi>TfinSxLo)
                    rTPulSxLo(CantPuls)=LN-TfinSxHi;
                    %*******TEMPORAL Para comparación entre los valores calculados y reales
                    rTPulSxLoIdeal(CantPulsIdeal)=LN-TfinSxHi;
                    %******
                end
            end
            %FIN CARACTERIZACIÓN DEL COMPORTAMIENTO TEMPORAL DE LA SEÑAL
        end
end% Función
% JORGE Y. HERNÁNDEZ GARCÍA
