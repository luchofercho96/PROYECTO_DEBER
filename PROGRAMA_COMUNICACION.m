%% CARGAR LA MEMORIA COMPARTIDA
clc,clear all,close all;
% loadlibrary('smClient64.dll','./smClient.h');
%% ABRIR MEMORIA COMPARTIDA
calllib('smClient64','openMemory','memoria_int',1);
%% ESCRIBIR EN LA MEMORIA ABIERTA
calllib('smClient64','setInt','memoria_int',1,2)