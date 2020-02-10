%Función para graficar los errores en normalizados de la amplitud y la frecuencia en función de la variación de la fs (FsVec)
%La leyenda se modifica en función de los valores (FsVec(n)/fy)
%)
function fGraf_ErrAmpFrecNormAnaFsNomLeyend(snrVec,rErrAm_TotNormFs,mErrFr_TotNorm,figNum,FsVec,fy)%

	%Establecer los límites de x
	L_snrVec=length(snrVec);
	Xfin=snrVec(L_snrVec);
	Xin=snrVec(1);

	% Crear figura
	%figure1 = figure(figNum);
	figure(figNum);

	% crear ejes
	% axes1 = axes('Parent',figure1);
	% hold(axes1,'on');
	% Crear múltiples líneas empleando la matriz de entrada a graficar
	plot1 = plot(snrVec,rErrAm_TotNormFs,snrVec,mErrFr_TotNorm);

	%NombLin1=['ErrAm_i'];
	NombLin2=['ErrFr_i Fs/Fy=' num2str(FsVec(1)/fy)];%fs(1)/fy
	NombLin3=['ErrFr_i Fs/Fy=' num2str(FsVec(2)/fy)];
	NombLin4=['ErrFr_i Fs/Fy=' num2str(FsVec(3)/fy)];
	NombLin5=['ErrFr_i Fs/Fy=' num2str(FsVec(4)/fy)];
	NombLin6=['ErrFr_i Fs/Fy=' num2str(FsVec(5)/fy)];% ,'LineWidth',3);
	NombLin7=['ErrFr_i Fs/Fy=' num2str(FsVec(6)/fy)];
	NombLin8=['ErrFr_i Fs/Fy=' num2str(FsVec(7)/fy)];
	NombLin9=['ErrFr_i Fs/Fy=' num2str(FsVec(8)/fy)];
	NombLin10=['ErrFr_i Fs/Fy=' num2str(FsVec(9)/fy)];
	NombLin11=['ErrFr_i Fs/Fy=' num2str(FsVec(10)/fy)];
	%NombLin12=['ErrFr_i Fs/Fy=' num2str(FsVec(10)/fy)];

	set(plot1(1),'DisplayName','ErrAm_i','Marker','o');
	set(plot1(2),'DisplayName',NombLin2);
	set(plot1(3),'DisplayName',NombLin3);
	set(plot1(4),'DisplayName',NombLin4);
	set(plot1(5),'DisplayName',NombLin5);
	set(plot1(6),'DisplayName',NombLin6);
	set(plot1(7),'DisplayName',NombLin7);
	set(plot1(8),'DisplayName',NombLin8);
	set(plot1(9),'DisplayName',NombLin9);
	set(plot1(10),'DisplayName',NombLin10);
	set(plot1(11),'DisplayName',NombLin11);
	%set(plot1(12),'DisplayName',NombLin12);

	%parametros Figura
	%Etiquetas
	xlabel('SNR (dB)','FontSize',12);% Create xlabel
	ylabel('Diferencia valor Real (%)','FontSize',12);% Create ylabel
	% Create Título
	title('Diferencia valor calculado y real de amplitud y frecuencia instantánea distintas SNR y Fs/Fy','FontSize',14);
	%Limites de los ejes
	axis([Xin,Xfin,-inf,100]);%Con el uso de inf se establece el limite
	grid on;
		
	% Create legend
	legend1 = legend('show');
	set(legend1,'Location','northeast','FontSize',10);	
	legend('boxoff');

 
end% Función fGraf_ErrAmpFrecNormAnaFsNomLeyend
%JORGE Y. HERNÁNDEZ GARCÍA


