Rh = sym('Rh');
Rd = sym('Rd');
Rf = sym('Rf');
Cd = sym('Cd');
Rc = 90.274e+6;
Cc = 4e-3;

num = [(Rh*Rc*Rd*Rf*Cc*Cd + Rh*Rf*Cc*Cd) (Rf*Rd*Cc+Rh*Rc*Cd) Rc];
den = [(Rf*Rh*Rc*Cc*Cd) (Rf*Rc*Cc)];

comp1 = [0.74308 1,9073e+4];
comp2 = [1 5294];

x = sym('x');
y = sym('y');

equa1 = (x == y - 2);
equa2 = (y == 2);


S = solve(equa1,equa2);


