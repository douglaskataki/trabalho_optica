clc;
clear;

% 
t0 = 0;
t1 = 20;
tspan = [t0 t1];

% Bombeios Copropagantes
P0 = [20e-3; 200e-3; 200e-3; 200e-3];
sol = ode45(@odefun,tspan,P0);

N = length(P0);
z = sol.x;
P = zeros(N,length(sol.y(1,:)));

for i=1:N
    P(i,:) = sol.y(i,:);
end

% interpolação
ii = 0.25;
zz = t0:ii:t1;

PP = zeros(N,length(zz));

for i=1:N
    PP(i,:) = spline(z,P(i,:),zz);
end

% plot dos gráficos
for i=1:N
    plot(zz,10*log10(PP(i,:)));
    hold on;
end
grid on;
xlabel('z(km)');
ylabel('P_t(dBm)');
legend('Sinal','Bombeio 1','Bombeio 2','Bombeio 3');