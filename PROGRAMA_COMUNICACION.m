%% CARGAR LA MEMORIA COMPARTIDA
clc,clear all,close all;
loadlibrary('smClient64.dll','./smClient.h');
%% ABRIR MEMORIA COMPARTIDA
calllib('smClient64','openMemory','memoria_int',2);
%% TIEMPO DE SAMPLEO
ts=0.1;
%% CONDICIONES INICIALES
t=0:ts:60;
lectura_1(1)=0;
%% senal de control inical
u(1)=0;
kp=1;
for k=1:length(t)
    tic;
    %% ESCRIBIR EN LA MEMORIA ABIERTA
    calllib('smClient64','setFloat','memoria_int',1,t(k)+rand(1));
    calllib('smClient64','setFloat','memoria_int',0,1+t(k));
    %% LECTURA EN LA MEMORIA ABIERTA
    lectura_1(k) = calllib('smClient64','getFloat','memoria_int',1);
    %% LEY DE CONTROL
    e(k)=lectura_1(k)-1;
    u(k+1)=kp*e(k);
    
    while(toc<ts)
    end
end
%% LIBERAR MEMORIA COMPARTIDA
calllib('smClient64','freeViews')
unloadlibrary smClient64