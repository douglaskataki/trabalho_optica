clc;
clear;

% Condi�oes iniciais para a solu��o do sistema
t0 = 0;
t1 = 50;
tspan = [t0 t1];

%% Bombeios Copropagantes
% Inicial
P0 = [20e-3; 200e-3; 200e-3; 200e-3];
% Resolve sistema de equa��es
sol = ode45(@odefun,tspan,P0);

%% Parametros para interpola��o
N = length(P0);
z = sol.x;
P = zeros(N,length(sol.y(1,:)));

for i=1:N
    P(i,:) = sol.y(i,:);
end

% interpola��o
ii = 0.25;
zz = t0:ii:t1;

PP = zeros(N,length(zz));

for i=1:N
    PP(i,:) = spline(z,P(i,:),zz);
end

% plot dos gr�ficos
for i=1:N
    txt = ['P(',num2str(i),')'];
    plot(zz,10*log10(PP(i,:)),'DisplayName',txt);
    hold on;
end
grid on;
hold off;
xlabel('z(km)');
ylabel('P_t(dBm)');
legend show;