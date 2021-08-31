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

%Limpando as variáveis de criação:
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%Modificação de vetores por conveniência e criação de variáveis:
T = Times(end,1);
t = Times;
df = 1/T;
N = size(Times,1);
x = XAxisms2
y = YAxisms2
z = ZAxisms2

%%%%%%%%%%%%%%%%% PLOTAGENS NO DOMÍNIO DO TEMPO %%%%%%%%%%%%%%%%%%%%
%Plotagem de aceleração em X x t:
figure(1)
subplot(3,1,1);
plot(t,x,'-b');
xlabel('tempo [s]');ylabel('aceleracao [m/s^2]');
title('Aceleração em relação a X')
axis([0,22,-5,5])

%Plotagem de aceleração em Y x t:
subplot(3,1,2);
plot(t,y,'-r');
xlabel('tempo [s]');ylabel('aceleracao [m/s^2]');
title('Aceleração em relação a Y')
axis([0,22,-5,5])

%Plotagem de aceleração em Z x t:
subplot(3,1,3)
plot(t,z,'-g');
xlabel('tempo [s]');ylabel('aceleracao [m/s^2]');
title('Aceleração em relação a Z')
axis([0,22,-5,5])

%%%%%%%%%%%%%%%%% TRANSFORMADAS DE FOURIER %%%%%%%%%%%%%%%%%%%%%%%%%

%Transformada rápida de Fourier para X:
Xtemp=fft(x-mean(x))/(N/2);
X=Xtemp(1:N/2);
f=linspace(0,df*(N/2),N/2);

%Transformada rápida de Fourier para Y:
Ytemp=fft(y-mean(y))/(N/2);
Y=Ytemp(1:N/2);
f=linspace(0,df*(N/2),N/2);

%Transformada rápida de Fourier para Z:
Ztemp=fft(z-mean(z))/(N/2);
Z=Ztemp(1:N/2);
f=linspace(0,df*(N/2),N/2);

%%%%%%%%%%%%%%% PLOTAGENS NO DOMÍNIO DA FREQUÊNCIA%%%%%%%%%%%%%%%%%%%%%

%Plotagem de aceleração em X x frequência:
figure(2)
subplot(3,1,1)
stem(f,abs(X),'-b');
xlabel('frequencia [Hz]');ylabel('aceleracao [m/s^2]');
title('Frequência em relação a X')
axis([0,50,0,0.8])

%Plotagem de aceleração em Y x frequência:
subplot(3,1,2)
stem(f,abs(Y),'-r');
xlabel('frequencia [Hz]');ylabel('aceleracao [m/s^2]');
title('Frequência em relação a Y')
axis([0,50,0,0.8])

%Plotagem de aceleração em Z x frequência:
subplot(3,1,3)
stem(f,abs(Z),'-g');
xlabel('frequencia [Hz]');ylabel('aceleracao [m/s^2]');
title('Frequência em relação a Z')
axis([0,50,0,0.8])
