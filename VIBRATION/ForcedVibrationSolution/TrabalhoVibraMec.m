%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%			File: Forced Vibration Solution			%
%			Name: Jonas M�ller Gon�alves			%
%			Aerospace Engineering/UFSM				%
%			Date: 23/04/2018						%
%			https://github.com/jonasmuller98		%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% ------------------------------------------------- %

clear;
t = [0:0.001:10];
% ----Solu��o de um sistema com vibra��o for�ada harm�nicamente e amortecimento ---- %

% A solu��o � dada por x = xh + xp, onde xh � uma solu��o harm�nica e xp �
% a solu��o particular. 

% Para cada caso de amortecimento, existe uma solu��o harm�nica diferente e
% a solu��o particular � dada por xp = X.*sin(w.*t + phi)         
    
%------- par�metros arbitr�rios ------ %  
m = 10;             %---- massa -----%
k = 4000;           %---- constante el�stica ----%
c = 20;             %---- constante de amortecimento ----%
w = 10;             %---- freq. angular ----%
F0 = 100;           %---- for�a inicial ----%

%------- par�metros derivados --------%
cc = 2.*sqrt(k.*m);                                  %---- coef. de amort. cr�tico ----% 
zeta = c/cc ;                                        %---- fator de amort. ----%
wn = sqrt(k./m) ;                                    %---- freq. natural ----%
r = [0:0.001:3] ;                                    %---- raz�o de frequ�ncias ----%
dest = F0./k ;                                       %---- deflex�o est�tica ----%
amp = 1./sqrt(((1-r.^2).^2) + ((2.*zeta.*r).^2)) ;   %---- fator de amplifica��o ----%
X = F0./sqrt(((k - m.*(w.^2)).^2) + (c.*w).^2) ;     %---- amplitude ----%
phi = atan2((c.*w),(k-m.*(w.^2))) ;                  %---- fase ----%


%------- Condi��es iniciais ------%
x0 = 0.01;                    %---- posi��o inicial ----%
v0 = 0 ;                      %---- velocidade inicial ----%

%---------------- Condicionais de Solu��o -------------------------%

if zeta < 1              %----- Subcr�tico -----%
     
    wd = wn.*sqrt(1 - (zeta.^2));
    
    %---- Constantes ---%
    c1 = x0 - X*cos(phi);
    c2 = (v0 + (zeta.*wn.*x0) - X.*(zeta.*wn.*cos(phi) + w.*sin(phi)))./wd;
    
    %---- Solu��o Geral ----%
    x = exp(-zeta.*t.*wn).*(c1.*cos(wd.*t) + c2.*sin(wd.*t)) + X.*cos(w.*t - phi);

elseif zeta == 1         %----- Cr�tico -----%
    
    %---- Constantes ----%
    c1 = x0 - X.*cos(phi) ;
    c2 = v0 + wn.*(x0 - X*cos(phi)) - X*w*sin(phi) ;
    
    %---- Solu��o Geral ----%
    x = c1.*exp(-wn.*t) + c2.*t.*exp(-wn.*t) + X.*cos(w.*t - phi);

elseif zeta > 1          %----- Supercr�tico -----%
    
    r1 = -zeta.*wn + wn.*sqrt((zeta.^2)-1);
    r2 = -zeta.*wn - wn.*sqrt((zeta^2)-1);
    
    %---- Constantes ----%
    c2 =  (v0 - r1.*x0 + X.*(r1*cos(phi) - w.*sin(phi)))/(r2 - r1) ;
    c1 = x0 - c2 - X.*cos(phi) ;
        
    %---- Solu��o Geral ----%
    x = c1.*exp(wn.*t.*(-zeta + sqrt(zeta.^2 - 1))) + c2.*exp(wn.*t.*(-zeta - sqrt(zeta.^2 - 1))) + X.*cos(w.*t - phi);

end 

%--------------- Fim das condicionais de solu��o ---------------------%

% -------- Inser��o do gr�fico 1 -------- %
subplot(2, 1, 1)
plot(t, x, 'r') ;
title ('Gr�fico x por t')
xlabel ('t')
ylabel ('x')
grid;
hold on ;
% ------- Inser��o do gr�fico 2 --------- %
subplot(2, 1, 2);
plot(r, amp, 'g');
title ('Gr�fico fator de amplifica��o por raz�o de frequ�ncias')
xlabel ('r')
ylabel ('Fator de Amplifica��o')
grid
hold on;