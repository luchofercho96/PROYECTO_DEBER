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
tfinal=120;
t=ti:ts1:tfinal;
%% senal de de entrada al sistema
u(1)=0;
e(1)=0;
%% senal deseada del sistema
yd(1)=0;
e_1(1)=0;
%% perturbacion del sistema
D(1)=0;
%% ganancias del controlador 
kp=5.26;
ki=0.0423;
Ts=ts1;
%% COMUNICACION MEMORIAS
loadlibrary('smClient64.dll','./smClient.h');
%% ABRIR MEMORIA COMPARTIDA
calllib('smClient64','openMemory','Sistema',2);
calllib('smClient64','openMemory','Senales',2);
%% Graficas en tiempo real
figure
axis equal;
h3=plot(t(1),y(1),'--r'); hold on
h4=plot(t(1),yd(1),'--g'); grid on
title('Animacion')
xlabel('x [m]'); ylabel('y [m]'); zlabel('Z [m]');
for k=1:length(t)
   tic;
   drawnow;
   delete(h3);
   delete(h4);
   %% planta simulada
   y(k)=-dend(2)*y_1(k)+numd(2)*u_1(k)+D(k);
   %% error del sistema
   e(k)=yd(k)-y(k);
   %% controlador del sistema
   u(k)=u_1(k)+kp*(e(k)-e_1(k))+ki*Ts*e_1(k);
   %% ESCRITURA DE SENAL DE CONTROL Y PLANTA 
   calllib('smClient64','setFloat','Sistema',0,y(k));
   calllib('smClient64','setFloat','Sistema',1,u(k));
   calllib('smClient64','setFloat','Sistema',2,e(k));
   %% LECTURA DE SENAL DESEADA Y PERTURBACION 
   yd(k+1) = calllib('smClient64','getFloat','Senales',0);
   D(k+1) = calllib('smClient64','getFloat','Senales',1);
   %% ACTUALIZACION DE ESTADOS
   e_1(k+1)=e(k);
   u_1(k+1)=u(k);
   y_1(k+1)=y(k);
   %% graficas del sistema
   h3=plot(t(1:k),y(1:k),"--r"); hold on 
   h4=plot(t(1:k),yd(1:k),"--g"); hold on
   grid on
   while(toc<Ts)
   end
   toc
   
end
%% LIBERAR MEMORIA COMPARTIDA
calllib('smClient64','freeViews')
unloadlibrary smClient64
%% grafica del sistema
figure()
subplot(4,1,1)
plot(t,e,'--r')
grid on;
hold on;
legend('Error de control')
subplot(4,1,2)
plot(t,D(1:length(t)),'--b')
grid on;
legend('Perturbacion')
subplot(4,1,3)
plot(t,y(1:length(t)),'--r')
hold on
plot(t,yd(1:length(t)),'--g')
grid on;
legend('Sistema Real','Referencia')
subplot(4,1,4)
plot(t,u_1(1:length(t)),'--b')
legend('Senal control')
grid on;