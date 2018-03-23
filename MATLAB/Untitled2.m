
Ra = 1000;
Rb = 10000;
Ca = 0.2e-6;
Cb = 0.1e-9;

num =[1];
den =[(Ra*Rb*Ca*Cb) ((Ra*Ca)+(Ra*Cb)+(Rb*Cb)) 1];

G = tf(num,den);

rltool(G);

--*-----------*--------------------*

((s^2)(Rh*Rc*Rd*Rf*Cc*Cd + Rh*Rf*Cc*Cd)+s(Rf*Rd*Cc+Rh*Rc*Cd)+Rc)/(s(s*Rf*Rh*Rc*Cc*Cd+Rf*Rc*Cc))

Rc = 90,274e+6;
(Rh*Rc*Rd*Rf*Cc*Cd + Rh*Rf*Cc*Cd) = 0.74308;
(Rf*Rd*Cc+Rh*Rc*Cd) = 1,9073e+4;
(Rf*Rh*Rc*Cc*Cd) = 1;
(Rf*Rc*Cc) = 5294;