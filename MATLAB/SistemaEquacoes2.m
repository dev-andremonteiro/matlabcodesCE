Rh = sym('Rh');
Rd = sym('Rd');
Rf = sym('Rf');
Cd = (4*(10^-3));
equa1=(Rh*(90.274*(10^6))*Rd*Rf*(4*(10^-3))*Cd + Rh*Rf*(4*(10^3))*Cd) == 0.74308;
equa2=(Rf*Rd*(4*(10^-3))+Rh*(90.274*(10^6))*Cd) == (1.9073*(10^4));
equa3=(Rf*Rh*(90.274*(10^6))*(4*(10^-3))*Cd) == 1;
equa4=(Rf*(90.274*(10^6))*(4*(10^-3))) == 5294;

S = solve(equa1,equa2,equa3,equa4);


*-----------------*---------------*

Rc = 120;
Cc = 0.2e-3;
Cd = 0.2e-3;


(Rh*Rc*Rd*Rf*Cc*Cd + Rh*Rf*Cc*Cd) = 1;
(Rf*Rd*Cc+Rh*Rc*Cd) = 18;
(Rf*Rh*Rc*Cc*Cd) = 1;
(Rf*Rc*Cc) = 10;



-----------*-----------------*----------*


eq = (Rd/Rc) + (1/s*Rf*Cc)+((s*Rh*Cd)/(s*Rg*Cd+1));

solve(eq,s);