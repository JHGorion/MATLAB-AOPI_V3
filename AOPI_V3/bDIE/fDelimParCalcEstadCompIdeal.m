%Funci�n. Selecciona los valores de los par�metros de entrada y coloca solo en la salida los valores en los �ndices donde PreSx toma valor igual a 1
%Calcula estadisticos de los par�metros reale e ideales para comparaci�n
function [rTPulSxHi,rTPulSxLo,CantPuls,rParAmi_DetProm,rParFri_DetProm,rTPulSxHiIdeal,rTPulSxLoIdeal,CantPulsIdeal,rParAmiIdeal_DetProm,rParFriIdeal_DetProm] = fDelimParCalcEstadCompIdeal(ParFri,GuardParFri,ParAmi,GuardParAmi,PreSx,N,AmP_i,FrP_i,GuardParAmiIdeal,GuardParFriIdeal)
    %**** Inicializaci�n de variables y registros
        LN=length(N);%Determina el n�mero de elementos de N para sincronismo se usa N 
        
        %***Par�metros temporales******
        TinSxHi=0;%Almacena temporalmente el �ndice de N para indicar el inicio de una sx en alto
        TfinSxHi=0;%Almacena temporalmente el �ndice de N para indicar el fin de una sx en alto
        TinSxLo=0;%Almacena temporalmente el �ndice de N para indicar el inicio de una sx en bajo
        TfinSxLo=0;%Almacena temporalmente el �ndice de N para indicar el fin de una sx en bajo
        rTPulSxHi=[];%Como no se conoce la dimensi�n se crea un vector vacio
        rTPulSxLo=[];%Como no se conoce la dimensi�n se crea un vector vacio
        CantPuls=0;%Se incrementa con casa pulso de la se�al en alto
                      
        %**Amplitud Instant�nea PAR�METROS
        rParAmi_Det=zeros(1,LN);% Registro que almacena los valores de la amplitud instant�nea promedio detectada
        rParAmi_DetProm=[];%Vector con los promedios de los valores mientras que hay presencia de se�al
        rParAmi_DetMin=[];%Vector con los valores m�nimos por cada detecci�n de presencia de se�al
        rParAmi_DetMax=[];%Vector con los valores m�ximos por cada detecci�n de presencia de se�al
        rParAmi_DetDelta=[];%Vector con la diferencia entre los valores m�ximos y m�nimos por cada detecci�n de presencia de se�al
                
        %**Frecuencia Instant�nea PAR�METROS
        rParFri_Det=zeros(1,LN);% Registro que almacena los valores De la frecuencia instant�nea promedio detectada
        rParFri_DetProm=[];%Vector con los promedios de los valores mientras que hay presencia de se�al
        rParFri_DetMin=[];%Vector con los valores m�nimos por cada detecci�n de presencia de se�al
        rParFri_DetMax=[];%Vector con los valores m�ximos por cada detecci�n de presencia de se�al
        rParFri_DetDelta=[];%Vector con la diferencia entre los valores m�ximos y m�nimos por cada detecci�n de presencia de se�al
        
        %*******TEMPORAL Para comparaci�n entre los valores calculados y reales
        rParAmiIdeal_Det=zeros(1,LN);
        rParAmiIdeal_DetProm=[];%Vector con los promedios de los valores reales de la amplitud de la se�al
        rParFriIdeal_Det=zeros(1,LN);
        rParFriIdeal_DetProm=[];%Vector con los promedios de los valores reales de la frecuencia de la se�al
        rTPulSxHiIdeal=[];%Como no se conoce la dimensi�n se crea un vector vac�o
        rTPulSxLoIdeal=[];%Como no se conoce la dimensi�n se crea un vector vac�o
        CantPulsIdeal=0;%Se incrementa con casa pulso de la se�al en alto 
        %*******
        
            
        for n=1:LN
            if(PreSx(n)>=1)%Si Hay detecci�n de se�al
                %Se selecciona solo los valores de los par�metros en los �ndices que PreSx>=1 
                rParAmi_Det(n)=ParAmi(n);
                rParFri_Det(n)=ParFri(n);
                %*******TEMPORAL Para comparaci�n entre los valores calculados y reales
                rParAmiIdeal_Det(n)=AmP_i(n);
                rParFriIdeal_Det(n)=FrP_i(n);
                %********    
                %Medici�n de la duraci�n de la se�al
                if (TinSxHi==0)
                    TinSxHi=n;%Almacena el valor del �ndice que indica el inicio se�al en alto
                    %           
                end
                %Medici�n de la duraci�n de la se�al en bajo
                if (TinSxLo>0)
                    TfinSxLo=n-1;%Almacena el valor del �ndice que indica el fin de se�al en bajo
                    TLo=TfinSxLo-TinSxLo;
                    if(TLo>1)%para descartar los valores igual a 0
                        rTPulSxLo(CantPuls)=TLo;
                        %*******TEMPORAL Para comparaci�n entre los valores calculados y reales
                        rTPulSxLoIdeal(CantPulsIdeal)=TLo;
                        %********
                    end
                    TinSxLo=0;
                end
            %Fin de Medici�n de la duraci�n de la se�al
            else % (SxMedDur(n)>0)
                %Se pone en 0 los intervalos de tiempo donde no se detecta Sx
                rParAmi_Det(n)=0;
                rParFri_Det(n)=0;
                %*******TEMPORAL Para comparaci�n entre los valores calculados y reales
                rParAmiIdeal_Det(n)=0;
                rParFriIdeal_Det(n)=0;
                %********
                %
                %Medici�n de la duraci�n de la se�al
                if (TinSxLo==0)
                    TinSxLo=n;%Almacena el primer valor
                end  
                %Medici�n de la duraci�n de la se�al en alto    
                if (TinSxHi>0)
                    TfinSxHi=n-1;%Almacena el ultimo valor
                    THi=TfinSxHi-TinSxHi;%Calcula la duraci�n de pulso
                    if(THi>1)%para descartar los valores igual a 0
                        CantPuls=CantPuls+1;%Incrementa la cantidad de pulsos (para se�ales pulsivas)
                        rTPulSxHi(CantPuls)=THi;%Almacena el valor de duraci�n de pulso en el arreglo
                        %*******TEMPORAL Para comparaci�n entre los valores calculados y reales
                        CantPulsIdeal=CantPulsIdeal+1;%Incrementa la cantidad de pulsos (para se�ales pulsivas)
                        rTPulSxHiIdeal(CantPulsIdeal)=THi;%Almacena el valor de duraci�n de pulso en el arreglo
                        %********
                    end
                    %
                    %Caracterizaci�n de los par�metros intra pulsos
                    %Amplitud
                    RangParAmi=(TinSxHi+GuardParAmi):(TfinSxHi-GuardParAmi);%Rango de selecci�n de valores del par�metro 1
                    rParAmi_DetProm(CantPuls)= mean(rParAmi_Det(RangParAmi));%Calcula Promedio de los valores entre dos �ndices 
                    rParAmi_DetMin(CantPuls)= min(rParAmi_Det(RangParAmi));%Vector con los valores m�nimos por cada detecci�n de presencia de se�al
                    rParAmi_DetMax(CantPuls)= max(rParAmi_Det(RangParAmi));%Vector con los valores m�ximos por cada detecci�n de presencia de se�al
                    rParAmi_DetDelta(CantPuls)=rParAmi_DetMax(CantPuls)-rParAmi_DetMin(CantPuls);%Vector con la diferencia entre los valores maximos y m�nimos por cada detecci�n de presencia de se�al
                    %
                    %Frecuencia
                    RangParFri=(TinSxHi+GuardParFri):(TfinSxHi-GuardParFri);%Rango de selecci�n de valores del par�metro 1
                    rParFri_DetProm(CantPuls)= mean(rParFri_Det(RangParFri));%Calcula Promedio de los valores entre dos �ndices 
                    rParFri_DetMin(CantPuls)= min(rParFri_Det(RangParFri));%Vector con los valores m�nimos por cada detecci�n de presencia de se�al
                    rParFri_DetMax(CantPuls)= max(rParFri_Det(RangParFri));%Vector con los valores m�ximos por cada detecci�n de presencia de se�al
                    rParFri_DetDelta(CantPuls)=rParFri_DetMax(CantPuls)-rParFri_DetMin(CantPuls);%Vector con la diferencia entre los valores m�ximos y m�nimos por cada detecci�n de presencia de se�al
                    %
                    %*******TEMPORAL Para comparaci�n entre los valores calculados y reales
                    RangParAmi=(TinSxHi+GuardParAmiIdeal):(TfinSxHi-GuardParAmiIdeal);%Rango de selecci'on de valores de amplitud ideal
                    RangParFri=(TinSxHi+GuardParFriIdeal):(TfinSxHi-GuardParFriIdeal);%Rango de selecci'on de valores del frecuencia ideal
                    rParAmiIdeal_DetProm(CantPulsIdeal)= mean(rParAmiIdeal_Det(RangParAmi));
                    rParFriIdeal_DetProm(CantPulsIdeal)= mean(rParFriIdeal_Det(RangParFri));
                    %******

                    TinSxHi=0; % inicializaci�n de la variable
                end
                %Fin de Medici�n de la duraci�n de la se�al
          
            end
            if(n==LN)% Resumir las caracter�sticas de la se�al
                %Caracterizaci�n de la se�al
                if (TinSxHi>=1 && TfinSxHi==0)%Para comprobar si se trata de una se�al continua
                   rTPulSxHi(1)=LN;
                   rTPulSxLo(1)=0;
                    %*******TEMPORAL Para comparaci�n entre los valores calculados y reales
                   rTPulSxHiIdeal(1)=LN;
                   rTPulSxLoIdeal(1)=0;
                   %******
                end
                %Para medir la ultima pausa.Agregado para ajustar cantidad de valores respecto a valores ideales
                if (TfinSxHi<LN && TfinSxHi>TfinSxLo)
                    rTPulSxLo(CantPuls)=LN-TfinSxHi;
                    %*******TEMPORAL Para comparaci�n entre los valores calculados y reales
                    rTPulSxLoIdeal(CantPulsIdeal)=LN-TfinSxHi;
                    %******
                end
            end
            %FIN CARACTERIZACI�N DEL COMPORTAMIENTO TEMPORAL DE LA SE�AL
        end
end% Funci�n
% JORGE Y. HERN�NDEZ GARC�A
