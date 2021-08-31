function Newmark(n,k,M,F,x0,v0,
t0 = 0;             %tempo inicial
tf = 10;            %tempo final
T = 0.0001;           %passo
t = t0:T:tf;        %intervalo de tempo

a = 1/4; %alfa
d = 1/6; %delta - usados em Newmark
c = 0;

file_name = input('Enter the file name :','s');
eval (file_name);      % Lê arquivo de entrada

n = 6*size(coordinates,1);

k = zeros (n,n); %prealocação
M = zeros (n,n);
x0 = zeros (n,n);
v0 = zeros (n,n);
[M, K, F] = Estretic(file_name,N_TimeSteps,InitTime,FinalTime)
%%%% PROBLEMA 2
% M =  [12 0 ; 0 8];
%     k =  [4000 -1000 ; -1000 2500];
%     c = 0;
%     F = [zeros(1 ,length(t) ) ; 10*cos(30.*t) ];
%     x0 = [0 ; 0.1];
%     v0 = [0 ; 0];

%%% problema 1
t = t0:T:tf;    
    M = 10;
    k = 40;
    F = zeros*t;
    s = 0.01; %zeta
    x0 = 0.5;
    v0 = 0;
    c = 0;
    wn = sqrt(k/M);
    wd = wn*sqrt(1 - s^2);
    %c = 2*M*s*wn;

%constantes de newmark

n = length(M); %matriz de zeros 
ni = fix ((tf-t0)/T); %numero de iterações
X3 = zeros (n, ni); %cria matriz de zeros pra armazenamento na memória
A3 = zeros (n, ni);
V3 = zeros (n, ni);


%constantes

b0 = 1/(a*T^2);
b1 = 1/(a*T);
b2 = (1/2*a)-1;
b3 = (1 - d)*T;
b4 = d*T;
b5 = b4*b0;
b6 = b4*b1 - 1;
b7 = b4*b2 - b3;

X3(:,1) = x0;  %condições iniciais                         
V3(:,1) = v0;
A3 = M\((F(:,1)-c*V3(:,1)-k*X3(:,1))); %determinar aceleração inicial

t0 = 0;
T = 0.01;


for i = 1:1:ni

X3(:, i+1) = (b0*M + b5*c + k)\((F(:, i+1) + M*(b0*X3(:,i)+b1*V3(:,i)+b2*A3(:,i))+c*(b5*X3(:,i)+b6*V3(:,i)+b7*A3(:,i))));
A3(:,i+1) = b0*(X3(:,i+1) - X3(:, i)) - b1*V3(:, i) - b2*A3(:, i);
V3(:, i+1) = b5*(X3(:, i+1)-X3(:,i))-b6*V3(:,i)-b7*A3(:,i);

end
% %%%%%%% SOLUÇÃO EXATA problema 2
% t = t0:T:tf;
%     xExato2 = [0.0406*cos(14.8433.*t)-0.0406*cos(20.6279.*t)+0.0003*cos(30.*t); 0.0551*cos(14.8433.*t)+0.0449*cos(20.6279.*t)-0.0022*cos(30.*t)];
%     figure(1)
%     plot(t, xExato2(2,:),'k')
%    hold on
 %%%% SOLUÇÃO EXATA PROBLEMA 1
    t = t0:T:tf;
    I = (tf-t0)/T;
    xExato = zeros(1,I);
    xExato = (exp(-s*wn.*t)).*(((v0+s*wn*x0)/wd).*sin(wd.*t)+x0*cos(wd.*t));
    figure(1)
    plot(t, xExato,'b')
    legend('xExato')
    hold on

 %%%%% PLOT NEWMARK

 t2 = 0:0.0001:10;
 plot(t2,X3(n,:),'r')
 legend('Sol exata','Newmark')
 xlabel ('tempo (s)')
 ylabel ('posição x')

%a3(i) = M\((F-c*v3(i)-k*x3(i)));
%x3(i+1)=(b0*M + b5*c + k)^-1.*(F + M*(b0*x3(i)+b1*v3(i)+b2*a3(i)) + c*(b5*x3(i)+b6*v3(i)+b7*a3(i)));      
%v3(i+1) = b5*(x3(i+1)-x3(i))-b6*v3(i)-b7*a3(i);