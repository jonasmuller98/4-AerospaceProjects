function[A2,V2,X2] = Dif_CFinitas (M,x0,v0,T,t0,tf,k,c,F)


n = length(M);          %matriz de zeros, toma como referência o tamanho da matriz de massa 
ni = fix ((tf-t0)/T);   %numero de iterações
X2 = zeros (n, ni);     %cria matriz de zeros pra armazenamento na memória
A2 = zeros (n, ni);
V2 = zeros (n, ni);



X2(:,1) = x0;           %condições iniciais                         
V2(:,1) = v0;
A2(:,1) = ((F(:,1)-c*V2(:,1)-k*X2(:,1)));
x2 = X2(:,1)-T*V2(:,1)+((T^2)/2)*A2(:,1); %equivalente ao x2(ti-1)
X2(:,2) = ((1/(T^2))*M+(c/2*T))\((F(:,1)-(k-(2*M/(T^2)))*X2(:,1)-((M/(T^2))-c/2*T)*x2)); 
X2(:,3) = ((1/(T^2))*M+(c/2*T))\((F(:,2)-(k-(2*M/(T^2)))*X2(:,2)-((M/(T^2))-c/2*T)*x0));
A2(:,2) = M\(F(:,2)-c*V2(:,2)-k*X2(:,2));

for i = 2:ni    %Cálculo iterativo
 
X2(:,i+1) = ((1/(T^2))*M+(1/(2*T))*c)\((F(:,i)-(k-(2*M/(T^2)))*X2(:,i)-((M/(T^2))-c/2*T)*X2(:,i-1)));
V2(:,i) = (1/2*T)*(X2(:,i+1)-X2(:,i-1));
A2(:,i) = (1/(T^2))*(X2(:,i+1)-2*X2(:,i)+X2(:,i-1));
    
end



