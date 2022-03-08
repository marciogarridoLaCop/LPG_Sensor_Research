%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   UNIVERSIDADE FEDERAL FLUMINENSE                       %
%                  LABORATÓRIO DE COMUNICAÇÕES ÓTICAS                     %
%    DESENVOLVIMENTO DE INSTRUMENTO PARA INTERROGAÇÃO DE SENSORES ÓTICOS  %
%               PROF. DR. ANDRÉS PABLO LOPEZ BARBERO                      %
%                    WEBER DE SOUZA GAIA FILHO                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variáveis de Limpeza
clc;
close all
clear all
%% CARREGANDO A AQUISIÇÃO DE DADOS DO DAQ6216
% load 'C:\Users\weber\Desktop\Dissertação - Simulador e  Interrogador LPG\3. Arquivos MATLAB\7. Interrogador LPG\2. 1800Hz\1543nm\Distorção 6%\DAQ6216_1s_10800.mat'
% load 'C:\Users\weber\Desktop\Dissertação - Simulador e  Interrogador LPG\3. Arquivos MATLAB\7. Interrogador LPG\2. 1800Hz\1543nm\Distorção 6%\DAQ6216_2s_10800.mat'
% load 'C:\Users\weber\Desktop\Dissertação - Simulador e  Interrogador LPG\3. Arquivos MATLAB\7. Interrogador LPG\2. 1800Hz\1543nm\Distorção 6%\DAQ6216_1s_14400.mat'
load 'C:\Users\weber\Desktop\Dissertação - Simulador e  Interrogador LPG\3. Arquivos MATLAB\7. Interrogador LPG\2. 1800Hz\1543nm\Distorção 6%\DAQ6216_2s_14400.mat'

% DAQ = volt1;
% clear volt1

% DAQ = volt2;
% clear volt2

% DAQ = volt3;
% clear volt3

DAQ = volt4;
clear volt4
%% 
t = (0:length(DAQ)-1)*(1/length(DAQ));                                      % Vetor para cálculo ddo tempo
Fs = 10800;                                                                 % Frequência de amostragem
% Fs = 14400;                                                               % Frequência de amostragem
[P1,aux_fase,f_plot] = FFT(DAQ,Fs);
%% 
f = 1800;
[index1, index2,aux2_fase] = Fase(f,Fs,aux_fase(1:length(P1)));
H1 = abs(P1(index1-2));
H2 = abs(P1(index2-6));
H = H1/H2;
dbH1 = 10*log10(H1);                                                        % Transformação para dB (H1)
dbH2 = 10*log10(H2);                                                        % Transformação para dB (H2)
plot(f_plot,10*log10(P1),'k')
%% COEFICIENTES PARA OBTENÇÃO DAS RAÍZES
Am = 0.44;                                                                  % Amplitude de modulação
a = 0.01;                                                                   % Largura espectral da LPG
Ad = 6;                                                                     % Porcentagem de distorção; File:DAQ_10800_1s_90.mat -mat
Lc = 1540;                                                                  % Comprimento de onda LPG
[A,B,C] = coeff(Am,a,Ad,H);
%% OBTENÇÃO DO COMPRIMENTO DE ONDA DA LPG
[Lr] = LambdaR(A,B,C,index2,aux2_fase,Lc);
[Lr2] = LambdaR2(A,B,C,index2,aux2_fase,Lc);