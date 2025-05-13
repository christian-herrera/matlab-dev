%% Ejemplo de Uso
% Esta clase permite resolver problemas de control clásico, como por ejemplo el análisis de la respuesta en frecuencia de un sistema de control 
% realimentado, el cálculo de los errores estáticos, el cálculo de la respuesta en estado estacionario, el análisis de la ubicación de los polos 
% y ceros, entre otros.

%% Sistema de Lazo Cerrado Sin Compensar
CI = ControlClasico();
G = tf(0.6*[-1/30 1], conv([1/5 1 0], [1/10 1]));
H = tf(1,1);


% Sin Compensador
CI.LGR(G, H);
% CI.nyquist(G*H)
% CI.ErroresEstaticos(G*H)
% CI.bode(G*H)
% CI.ValEstadoEstacionario(G, H);
% CI.PolosyCerosLC(G,H);

%% Sistema de Lazo Cerrado Compensado
CI = ControlClasico();
C = tf(1, [1 1]);
G = tf(0.6*[-1/30 1], conv([1/5 1 0], [1/10 1]));
H = tf(1,1);


% Sin Compensador
% CI.LGR(G, H);
% CI.nyquist(G*H)
% CI.ErroresEstaticos(G*H)
CI.bode(G*H)
% CI.ValEstadoEstacionario(G, H);
% CI.PolosyCerosLC(G,H);