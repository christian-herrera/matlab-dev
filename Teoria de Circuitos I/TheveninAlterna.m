% Algoritmo -> Equivalente de Thevenin para Corriente Alterna
% IMPORTANTE: Todos los valores de corriente y tension estan en RMS
%
% Calcula y grafica todos los parametros
% - Impedancia Total
% - Corriente
% - Phi (Desfase entre V e I)
% - Potencias Complejas para Zth, ZL y Uf
% - Potencias Activa, Reactiva y Aparente

function [  ] = TheveninAlterna( Vth, Zth, Zl)
    Zt = Zth + Zl;                              %Impedancia total
    I = Vth / Zt;                               %Corriente total
    phi = (angle(I) - angle(Vth)) * (180/pi);   %Desfasaje entre V e I
    Fp = cosd(phi);                             %Factor de potencia
    
    %Carga Zth
    Sc1 = abs(I)^2  * Zth;
    P1 = real(Sc1);
    Q1 = imag(Sc1);
    phi1 = atand(P1/Q1);
    
    %Carga ZL
    Sc2 = abs(I)^2  * Zl;
    P2 = real(Sc2);
    Q2 = imag(Sc2);
    phi2 = atand(P2/Q2);
    
    %Totales
    P = P1 + P2;
    Q = Q1 + Q2;
    S = sqrt(P^2 + Q^2);
    
    figure('Name', 'Equivalente de Thevenin para Corriente Alterna', 'NumberTitle','off');
    %==> Vectores de Tension-Corriente
    subplot(1,2,1);
    grid;
    plot([0, real(Vth)], [0, imag(Vth)], [0, real(I)], [0, imag(I)], 'Marker', '.', 'MarkerSize', 10, 'LineWidth', 2);
    str1 = strcat('Grafica Tension-Corriente (phi=', num2str(phi), '°, Fp=', num2str(Fp), ')');
    title(str1);
    legend('Corriente', 'Voltaje de Thevenin');
    
    %Potencias Acctiva, Reactiva y Aparente
    subplot(1,2,2);
    plot([0, P], [0, 0], [P, P], [0, Q], [0, P], [0, Q], 'LineWidth', 2);
    grid;
    title('Triangulo de Potencia');
    pot1 = strcat('Potencia Activa (P) =  ', num2str(P), ' W');
    pot2 = strcat('Potencia Reactiva (Q) =  ', num2str(Q), ' VAR');
    pot3 = strcat('Potencia Aparente (|S|) =  ', num2str(S), ' VA');
    legend(pot1, pot2, pot3);

    
    %==> Imprimo todos los valores por consola
    fprintf('==> Todos los valores de V e I estan en valores RMS <==\n');
    fprintf('-> Impedancia Total: %3.3f + j(%3.3f)   [%3.3f | %3.3f°]\n', real(Zt), imag(Zt), abs(Zt), rad2deg(angle(Zt)));
    fprintf('-> Corriente: %3.3f + j(%3.3f)   [%3.3f | %3.3f°]\n', real(I), imag(I), abs(I), rad2deg(angle(I)));
    fprintf('-> Phi: %3.3f\n', abs(phi));
    if(phi < 0)
        fprintf('-> Fp: %3.3f en atraso (Inductivo)', Fp);
    else
        fprintf('-> Fp: %3.3f en adelanto (Capacitivo)', Fp);
    end
    fprintf('\n\n-> Carga Zth -> [phi=%3.3f°] [P=%3.3f W]  [Q=%3.3f VAR]\n', phi1, P1, Q1);
    fprintf('-> Carga ZL  -> [phi=%3.3f°] [P=%3.3f W]  [Q=%3.3f VAR]\n\n', phi2, P2, Q2);
    fprintf('-> Potencia Activa: %3.3f W\n', P);
    fprintf('-> Potencia Reactiva: %3.3f VAR\n', Q);
    fprintf('-> Potencia Aparente: %3.3f VA\n', S);
 
    
end

