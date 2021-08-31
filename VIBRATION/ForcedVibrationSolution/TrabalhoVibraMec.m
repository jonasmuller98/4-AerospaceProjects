%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%			File: Forced Vibration Solution			%
%			Name: Jonas Müller Gonçalves			%
%			Aerospace Engineering/UFSM				%
%			Date: 23/04/2018						%
%			https://github.com/jonasmuller98		%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% ------------------------------------------------- %

clear;
t = [0:0.001:10];
% ----Solução de um sistema com vibração forçada harmônicamente e amortecimento ---- %

% A solução é dada por x = xh + xp, onde xh é uma solução harmônica e xp é
% a solução particular. 

% Para cada caso de amortecimento, existe uma solução harmônica diferente e
% a solução particular é dada por xp = X.*sin(w.*t + phi)         
    
%------- parâmetros arbitrários ------ %  
m = 10;             %---- massa -----%
k = 4000;           %---- constante elástica ----%
c = 20;             %---- constante de amortecimento ----%
w = 10;             %---- freq. angular ----%
F0 = 100;           %---- força inicial ----%

%------- parâmetros derivados --------%
cc = 2.*sqrt(k.*m);                                  %---- coef. de amort. crítico ----% 
zeta = c/cc ;                                        %---- fator de amort. ----%
wn = sqrt(k./m) ;                                    %---- freq. natural ----%
r = [0:0.001:3] ;                                    %---- razão de frequências ----%
dest = F0./k ;                                       %---- deflexão estática ----%
amp = 1./sqrt(((1-r.^2).^2) + ((2.*zeta.*r).^2)) ;   %---- fator de amplificação ----%
X = F0./sqrt(((k - m.*(w.^2)).^2) + (c.*w).^2) ;     %---- amplitude ----%
phi = atan2((c.*w),(k-m.*(w.^2))) ;                  %---- fase ----%


%------- Condições iniciais ------%
x0 = 0.01;                    %---- posição inicial ----%
v0 = 0 ;                      %---- velocidade inicial ----%

%---------------- Condicionais de Solução -------------------------%

if zeta < 1              %----- Subcrítico -----%
     
    wd = wn.*sqrt(1 - (zeta.^2));
    
    %---- Constantes ---%
    c1 = x0 - X*cos(phi);
    c2 = (v0 + (zeta.*wn.*x0) - X.*(zeta.*wn.*cos(phi) + w.*sin(phi)))./wd;
    
    %---- Solução Geral ----%
    x = exp(-zeta.*t.*wn).*(c1.*cos(wd.*t) + c2.*sin(wd.*t)) + X.*cos(w.*t - phi);

elseif zeta == 1         %----- Crítico -----%
    
    %---- Constantes ----%
    c1 = x0 - X.*cos(phi) ;
    c2 = v0 + wn.*(x0 - X*cos(phi)) - X*w*sin(phi) ;
    
    %---- Solução Geral ----%
    x = c1.*exp(-wn.*t) + c2.*t.*exp(-wn.*t) + X.*cos(w.*t - phi);

elseif zeta > 1          %----- Supercrítico -----%
    
    r1 = -zeta.*wn + wn.*sqrt((zeta.^2)-1);
    r2 = -zeta.*wn - wn.*sqrt((zeta^2)-1);
    
    %---- Constantes ----%
    c2 =  (v0 - r1.*x0 + X.*(r1*cos(phi) - w.*sin(phi)))/(r2 - r1) ;
    c1 = x0 - c2 - X.*cos(phi) ;
        
    %---- Solução Geral ----%
    x = c1.*exp(wn.*t.*(-zeta + sqrt(zeta.^2 - 1))) + c2.*exp(wn.*t.*(-zeta - sqrt(zeta.^2 - 1))) + X.*cos(w.*t - phi);

end 

%--------------- Fim das condicionais de solução ---------------------%

% -------- Inserção do gráfico 1 -------- %
subplot(2, 1, 1)
plot(t, x, 'r') ;
title ('Gráfico x por t')
xlabel ('t')
ylabel ('x')
grid;
hold on ;
% ------- Inserção do gráfico 2 --------- %
subplot(2, 1, 2);
plot(r, amp, 'g');
title ('Gráfico fator de amplificação por razão de frequências')
xlabel ('r')
ylabel ('Fator de Amplificação')
grid
hold on;