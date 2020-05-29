clc,clear all,close all;
%% constates de la planta
ks1=1;
ts1=0.1;
%% planta en dominio de la frecuencia
num=ks1*1.5;
den=[157 1];
Gs=tf(num,den);
%% descretizacion de la planta
dsys=c2d(Gs,ts1,'z');
%% obtencion de coeficientes
[numd,dend]=tfdata(dsys,'v');
%% variables de almacenamiento
y(1)=0;
y_1(1)=0;
u_1(1)=0;
%% tiempo de simulacion
ti=0;
tfinal=1500;
t=ti:ts1:tfinal;
%% senal de de entrada al sistema
u=1*ones(1,length(t));
%% senal deseada del sistema
yd=[10*ones(1,round(length(t)/2)),20*ones(1,round(length(t)/2)+1)];
e_1(1)=0;
%% perturbacion del sistema
D=0*ones(1,length(t));
%% ganancias del controlador 
kp=5.26;
ki=0.0423;
Ts=ts1;
for k=1:length(t)
    
   %% planta simulada
   y(k)=-dend(2)*y_1(k)+numd(2)*u_1(k)+D(k);
   
   %% error del sistema
   e(k)=yd(k)-y(k);
   
   %% controlador del sistema
   u(k)=u_1(k)+kp*(e(k)-e_1(k))+ki*Ts*e_1(k);
%    if(u(k)<0)
%       u(k)=0; 
%    end
   %% retroalimentacion variables
   e_1(k+1)=e(k);
   u_1(k+1)=u(k);
   y_1(k+1)=y(k);
   %% seccion de perturbacion simulada
   if(t(k)>200 & t(k)<400)
      D(k+1)=-0.05; 
   elseif(t(k)>1000 & t(k)<1300)
      D(k+1)=0.05;
   else
       D(k+1)=0;
   end
   
end
%% grafica del sistema
figure()
subplot(4,1,1)
step(Gs)
grid on;
hold on;
legend('planta en s')
subplot(4,1,2)
plot(t,D(1:length(t)),'--b')
grid on;
legend('perturbacion')
subplot(4,1,3)
plot(t,y(1:length(t)),'--r')
hold on
plot(t,yd(1:length(t)),'--g')
grid on;
legend('sistema','referencia')
subplot(4,1,4)
plot(t,u_1(1:length(t)),'--b')
legend('senal control')
grid on;