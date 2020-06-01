clc,clear all,close all;
to=0;
ts=0.1;
tf=20;
t=to:ts:tf;
x=sin(t);
y=cos(t);
figure
plot(x,y,'--r')
grid on
legend('trayectoria')
figure
plot(t,x,'--r')
grid on
legend('componente x')
figure
plot(t,y,'--g')
grid on
legend('componente y')
points=[x;y];
tiempo=[0 20];
