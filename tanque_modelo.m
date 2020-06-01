clc,clear all,close all;
%% constantes del sistema
A=0.5;
k1=0.05;
k2=0.015;
g=9.81;
%% tiempo de simulacion
ti=0;
ts=0.1;
tf=21;
t=ti:ts:tf+ts;
%% apertuda de valvulas;
a1=[0.1*ones(1,length(t)/2),0*ones(1,length(t)/2)];
a2=[0*ones(1,length(t)/2),0.1*ones(1,length(t)/2)];
%% condiciones iniciales
h(1)=0;
for k=1:length(t)
    J=[k1/A,-k2*sqrt(2*g*h(k))/A];
    v=[a1(k),a2(k)]';
    hp=J*v;
    h(k+1)=h(k)+ts*hp;
end
figure
plot(t,h(1:length(t)),'k')
hold on
plot(t,a2,'--b')
plot(t,a1,'--r')
grid on
legend('altura','valvula entrada control','valvula salida perturbacion')