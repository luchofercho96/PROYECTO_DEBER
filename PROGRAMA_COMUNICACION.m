%% CARGAR LA MEMORIA COMPARTIDA
clc,clear all,close all;
loadlibrary('smClient64.dll','./smClient.h');
%% ABRIR MEMORIA COMPARTIDA
calllib('smClient64','openMemory','memoria_int',1);
%% ESCRIBIR EN LA MEMORIA ABIERTA
calllib('smClient64','setInt','memoria_int',1,56)
%% LEER UN VALOR DE LA MEMEORIA
lectura_1 = calllib('smClient64','getInt','memoria_int',1)
lectura_0 = calllib('smClient64','getInt','memoria_int',0)
%% LIBERAR MEMORIA COMPARTIDA
calllib('smClient64','freeViews')
unloadlibrary smClient64