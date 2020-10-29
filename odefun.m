function dP = odefun(z,P)

c = physconst('LightSpeed');
h = 6.62607004e-34;
T = 273+25;
k = physconst('Boltzmann');
% load("Fibra_Standart_Att"); % lambda(nm) x Atenuação
% load("Fibra_Standart_Aeff"); % lambda(nm) x Aeff (nm^2)

% ls -> comprimento de onda do sinal
% demais são dos bombeios

ls = 1400e-9; %nm
lp = [ls 1310e-9 1320e-9 1300e-9]; %nm
freq = c./lp;

% Parâmetros inicias, atenuação e area efetiva
a_s = 0.3;
Aeff = 20e-4;

% Alocação de memória para o sinal e bombeios
N = length(lp);
dP = zeros(N,1);

%% Sistema de equações diferenciais
% P(1) -> Sinal 
% demais são bombeios
% neste programa só estão sendo considerados os sinais copropagantes
% ref: MEZCLA DE CUATRO ONDAS EN AMPLIFICADORES RAMAN DISTRIBUIDOS EN REDES
% OPTICAS WDM, Marcelo Alfonso Soto Hernandez

for i=1:N
    dP(i) = -a_s*P(i);
    for j=1:N
        if freq(i) < freq(j)
            dP(i) = dP(i) + P(i)*(gain(freq(i)/1e13)/Aeff)*P(j)...
                +2*h*freq(i)*P(j)*(1+1/exp(h*abs(freq(i)-freq(j))/(k*T)-1))*abs(freq(j)-freq(i)) ...
                -4*h*freq(i)*P(i)*(gain(freq(i)/1e13)/Aeff)*(1+1/exp(h*abs(freq(i)-freq(j))/(k*T)-1))*abs(freq(j)-freq(i));
        else
            dP(i) = dP(i) - P(i)*(freq(i)/freq(j))*(gain(freq(j)/1e13)/Aeff)*P(j)...
                -4*h*freq(i)*P(i)*(1+1/exp(h*abs(freq(i)-freq(j))/(k*T)-1))*abs(freq(i)-freq(j))...
                +2*h*freq(i)*P(j)*(gain(freq(i)/1e13)/Aeff)*(1/exp(h*abs(freq(i)-freq(j))/(k*T)-1))*abs(freq(j)-freq(i));
        end
    end
end
end