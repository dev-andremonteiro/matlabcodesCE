clear all
clc

%Especificações

%Gfp = 0 ~ -1dB
%Afr = -15dB
Td = 1;
syms x


f = piecewise([x < 0 | x > 1, 0], [x >= 0 & x <= 1, 1]);


plot (H,w);

