
function[A1,V1,X1] = Acel_constante (M,x0,v0,T,t0,tf,k,c,F)


n = length(M); %matriz de zeros 
ni = fix ((tf-t0)/T); %numero de iterações
X1 = zeros (n, ni); %cria matriz de zeros pra armazenamento na memória
A1 = zeros (n, ni);
V1 = zeros (n, ni);

X1(:,1) = x0;  %condições iniciais                         
V1(:,1) = v0;
A1(:,1) = M\((F(:,1) - c*V1(:,1) - k*X1(:,1)));


for i = 1:ni
    
    A1(:,i) = M\((F(:,i) - c*V1(:,i) - k*X1(:,i))); %aceleração
    V1(:,i+1) = V1(:,i) + A1(:,i)*T;                %velocidade
    X1(:,i+1) = X1(:,i) + T*V1(:,i)+((T^2)/2)*A1(:,i);  %posição
end
end