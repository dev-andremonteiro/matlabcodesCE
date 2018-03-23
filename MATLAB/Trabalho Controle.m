
Ra = 1000;
Rb = 10000;
Ca = 0.2e-6;
Cb = 0.1e-9;

num =[1];
den =[(Ra*Rb*Ca*Cb) ((Ra*Ca)+(Ra*Cb)+(Rb*Cb)) 1];

G = tf(num,den);


rltool(G);