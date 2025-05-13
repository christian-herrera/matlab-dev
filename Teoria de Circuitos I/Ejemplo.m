clc;
clear;
format short g;
crearZ = @(a, b)( (a * cosd(b)) + i*(a * sind(b)));

V_RN = crearZ(220, 30);
V_SN = crearZ(220, -90);
V_TN = crearZ(220, -210);

Z1 = crearZ(106, 60);
Z2 = Z1;
Z3 = Z1;
Zn = crearZ(10, 45);

%TheveninAlterna(V_RN, Z1, Z3);
%EstrellaEstrellaSinNeutro(V_RN, V_SN, V_TN, Z1, Z2, Z3);
%EstrellaTriangulo(V_RN, V_SN, V_TN, Z1, Z2, Z3);
%EstrellaEstrellaConZn(V_RN, V_SN, V_TN, Z1, Z2, Z3, Zn);
%EstrellaEstrellaConNeutro(V_RN, V_SN, V_TN, Z1, Z2, Z3);
%TrianguloTriangulo(V_RN, V_SN, V_TN, Z1, Z2, Z3);