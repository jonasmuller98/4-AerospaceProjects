clear;
%Inserindo o arquivo:
filename = 'caminhada3.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);

%Gerando os vetores:
Times = dataArray{:, 1};
XAxisms2 = dataArray{:, 2};
YAxisms2 = dataArray{:, 3};
ZAxisms2 = dataArray{:, 4};

%Limpando as vari�veis de cria��o:
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%Modifica��o de vetores por conveni�ncia e cria��o de vari�veis:
T = Times(end,1);
t = Times;
df = 1/T;
N = size(Times,1);
x = XAxisms2
y = YAxisms2
z = ZAxisms2

%%%%%%%%%%%%%%%%% PLOTAGENS NO DOM�NIO DO TEMPO %%%%%%%%%%%%%%%%%%%%
%Plotagem de acelera��o em X x t:
figure(1)
subplot(3,1,1);
plot(t,x,'-b');
xlabel('tempo [s]');ylabel('aceleracao [m/s^2]');
title('Acelera��o em rela��o a X')
axis([0,22,-5,5])

%Plotagem de acelera��o em Y x t:
subplot(3,1,2);
plot(t,y,'-r');
xlabel('tempo [s]');ylabel('aceleracao [m/s^2]');
title('Acelera��o em rela��o a Y')
axis([0,22,-5,5])

%Plotagem de acelera��o em Z x t:
subplot(3,1,3)
plot(t,z,'-g');
xlabel('tempo [s]');ylabel('aceleracao [m/s^2]');
title('Acelera��o em rela��o a Z')
axis([0,22,-5,5])

%%%%%%%%%%%%%%%%% TRANSFORMADAS DE FOURIER %%%%%%%%%%%%%%%%%%%%%%%%%

%Transformada r�pida de Fourier para X:
Xtemp=fft(x-mean(x))/(N/2);
X=Xtemp(1:N/2);
f=linspace(0,df*(N/2),N/2);

%Transformada r�pida de Fourier para Y:
Ytemp=fft(y-mean(y))/(N/2);
Y=Ytemp(1:N/2);
f=linspace(0,df*(N/2),N/2);

%Transformada r�pida de Fourier para Z:
Ztemp=fft(z-mean(z))/(N/2);
Z=Ztemp(1:N/2);
f=linspace(0,df*(N/2),N/2);

%%%%%%%%%%%%%%% PLOTAGENS NO DOM�NIO DA FREQU�NCIA%%%%%%%%%%%%%%%%%%%%%

%Plotagem de acelera��o em X x frequ�ncia:
figure(2)
subplot(3,1,1)
stem(f,abs(X),'-b');
xlabel('frequencia [Hz]');ylabel('aceleracao [m/s^2]');
title('Frequ�ncia em rela��o a X')
axis([0,50,0,0.8])

%Plotagem de acelera��o em Y x frequ�ncia:
subplot(3,1,2)
stem(f,abs(Y),'-r');
xlabel('frequencia [Hz]');ylabel('aceleracao [m/s^2]');
title('Frequ�ncia em rela��o a Y')
axis([0,50,0,0.8])

%Plotagem de acelera��o em Z x frequ�ncia:
subplot(3,1,3)
stem(f,abs(Z),'-g');
xlabel('frequencia [Hz]');ylabel('aceleracao [m/s^2]');
title('Frequ�ncia em rela��o a Z')
axis([0,50,0,0.8])
