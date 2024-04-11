set
i alimento/arroz, lasanha, feijao, soja, milho, vaca, frango, peixe, porco, alface, tomate, rucula, pepino, torta, maca, laranja, gelatina, maionese/
j nutriente/A,B,C,D/;

parameters

a(i) preços de compra ($-g)
/
arroz    0.002
lasanha  0.009
feijao   0.01
soja     0.008
milho    0.003
vaca     0.02
frango   0.012
peixe    0.023
porco    0.018
alface   0.011
tomate   0.007
rucula   0.005
pepino   0.02
torta    0.015
maca     0.01
laranja  0.001
gelatina 0.006
maionese 0.01
/

b(j) min nutriente (g-pf)
/
A 4
B 8
C 2
D 2
/

c(j) max nutriente (g-pf)
/
A 120
B 110
C 150
D 180
/

d(i) origem animal
/
arroz    0
lasanha  0
feijao   0
soja     0
milho    0
vaca     1
frango   1
peixe    1
porco    1
alface   0
tomate   0
rucula   0
pepino   0
torta    0
maca    0
laranja  0
gelatina 0
maionese 0
/

e(i) maionese
/ 
arroz    0
lasanha  0
feijao   0
soja     0
milho    0
vaca     0
frango   0
peixe    0
porco    0
alface   0
tomate   0
rucula   0
pepino   0
torta    0
maca     0
laranja  0
gelatina 0
maionese 1
/

f(i) sobremesa
/
arroz    0
lasanha  0
feijao   0
soja     0
milho    0
vaca     0
frango   0
peixe    0
porco    0
alface   0
tomate   0
rucula   0
pepino   0
torta    1
maca     1
laranja  1
gelatina 1
maionese 0
/

g(i) vegetais
/
arroz    0
lasanha  0
feijao   0
soja     0
milho    0
vaca     0
frango   0
peixe    0
porco    0
alface   1
tomate   1
rucula   1
pepino   1
torta    0
maca     0
laranja  0
gelatina 0
maionese 0
/;

table h(j,i)
   arroz  lasanha feijao   soja   milho    vaca   frango  peixe   porco   alface tomate rucula  pepino   torta    maca  laranja gelatina maionese
A   0.10    0.00   0.20    0.02    0.50    0.30    0.40    0.80    0.90    0.00   0.25    0.00    0.10    0.40    0.80    0.00    0.30    0.70      
B   0.20    0.13   0.15    0.30    0.07    0.14    0.04    0.05    0.02    0.10   0.00    0.05    0.40    0.01    0.01    0.30    0.20    0.03
C   0.05    0.70   0.00    0.00    0.30    0.08    0.15    0.00    0.00    0.15   0.20    0.27    0.10    0.06    0.10    0.50    0.70    0.06
D   0.00    0.08   0.70    0.10    0.00    0.00    0.00    0.30    0.20    0.70   0.30    0.60    0.10    0.35    0.30    0.10    0.00    0.05;

scalar
amin mínimo de alimentos de origem animal em gramas /70/
mmax máximo de maionese em gramas /30/
smmin mínimo de sobremesa em gramas /50/
smmax máximo de sobremesa em gramas /80/
ptmin peso total mínimo da refeição em gramas /500/
ptmax peso total máximo da refeição em gramas /600/
;

variables 
x(i) gramas do alimento i em um PF
z custo do PF;
positive variables x;

equations
obj função objetivo
nutrimax(j) max nutriente
nutrimin(j) min nutriente
animalmin mín origem animal
maiomax máx maionese
sobremax peso max sobremesa
sobremin peso min sobremesa
vegetalmax porcentagem do peso dos vegetais
vegetalmin porcentagem do peso dos vegetais
pesototalmax peso total da refeição
pesototalmin peso total da refeição;

obj..z =e= sum(i, x(i)*a(i));

animalmin.. sum(i, x(i)*d(i)) =g= amin;

maiomax.. sum(i, x(i)*e(i)) =l= mmax;

nutrimin(j).. sum(i, x(i)*(h(j,i))) =g= b(j);
nutrimax(j).. sum(i, x(i)*(h(j,i))) =l= c(j);

sobremin.. sum(i, x(i)*f(i)) =g= smmin; 
sobremax.. sum(i, x(i)*f(i)) =l= smmax;

pesototalmin.. sum(i, x(i)) =g= ptmin;
pesototalmax.. sum(i, x(i)) =l= ptmax;

vegetalmin.. sum(i, x(i)*g(i)) =g= 0.1*sum(i,x(i));
vegetalmax.. sum(i, x(i)*g(i)) =l= 0.2*sum(i,x(i));

model pratofeito/all/;
solve pratofeito using lp minimizing z;
display x.l,z.l

 


