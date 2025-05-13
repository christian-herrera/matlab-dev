% Sistema Triangulo - Triangulo
%
% Recibe la tension de referencia (V_RS) y la direccion de la secuencia 
% (1 o -1), luego, las 3 cargas de cada una de las fases.
%
% El algoritmo imprime las tensiones de linea y las corrientes.
% ademas, grafica estos vectores.

function [  ] = TrianguloTriangulo( V_RS, V_ST, V_TR, Zrs, Zst, Ztr )    
    %Obtengo las corrientes de fase
    I_rs = V_RS/Zrs;
    I_st = V_ST/Zst;
    I_tr = V_TR/Ztr;
    
    %Obtengo las corrientes de linea
    I_Rr = I_rs - I_tr;
    I_Ss = I_st - I_rs;
    I_Tt = I_tr - I_st;
    
    %Obtengo las potencias
    S_rs = V_RS * conj(I_rs);
    S_st = V_ST * conj(I_st);
    S_tr = V_TR * conj(I_tr);
    S_t = S_rs + S_st + S_tr;
    phi = rad2deg(angle(S_t));
    Fp = cos(phi);
    
    %Imprimo los valores por consola
    fprintf('==> Tensiones de Linea (Carga) = Tensiones de Fase <==\nV_RS: %3.3f | %3.3f\t\t', abs(V_RS), rad2deg(angle(V_RS)));
    fprintf('V_ST: %3.3f | %3.3f\t\t', abs(V_ST), rad2deg(angle(V_ST)));
    fprintf('V_TR: %3.3f | %3.3f\n\n', abs(V_TR), rad2deg(angle(V_TR)));
    fprintf('==> Corrientes de Linea <==\nI_rs: %3.3f | %3.3f\t\t', abs(I_rs), rad2deg(angle(I_rs)));
    fprintf('I_st: %3.3f | %3.3f\t\t', abs(I_st), rad2deg(angle(I_st)));
    fprintf('I_tr: %3.3f | %3.3f\n\n', abs(I_tr), rad2deg(angle(I_tr)));
    fprintf('==> Corrientes de Fase <==\nI_rs: %3.3f | %3.3f\t\t', abs(I_Rr), rad2deg(angle(I_Rr)));
    fprintf('I_st: %3.3f | %3.3f\t\t', abs(I_Ss), rad2deg(angle(I_Ss)));
    fprintf('I_tr: %3.3f | %3.3f\n', abs(I_Tt), rad2deg(angle(I_Tt)));
    fprintf('==> Potencias Complejas <==\nS_rs: %3.3f | %3.3f\t\t', real(S_rs), imag(S_rs));
    fprintf('S_st: %3.3f | %3.3f\t\t', real(S_st), imag(S_st));
    fprintf('S_tr: %3.3f | %3.3f\n', abs(S_tr), rad2deg(angle(S_tr)));
    
    figure('Name', 'Sistema Triangulo - Triangulo', 'NumberTitle','off');
    %Grafico Voltajes
    subplot(2,2,1);
    hold on;
    p1 = plot([0, real(V_RS)], [0, imag(V_RS)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_ST)], [0, imag(V_ST)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_TR)], [0, imag(V_TR)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    hold off;
    text(real(V_RS), imag(V_RS),'\leftarrow V_{RS}');
    text(real(V_ST), imag(V_ST),'\leftarrow V_{ST}');
    text(real(V_TR), imag(V_TR),'\leftarrow V_{TR}');
    title('Voltajes de Fase');
    legend([p1], {'Tensiones de Fase'});
    grid;
    axis square;
    
    %Graficos de Corrientes
    subplot(2,2,2);
    hold on;
    p3 = plot([0, real(I_rs)], [0, imag(I_rs)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(I_st)], [0, imag(I_st)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(I_tr)], [0, imag(I_tr)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    p4 = plot([0, real(I_Rr)], [0, imag(I_Rr)], 'b', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(I_Ss)], [0, imag(I_Ss)], 'b', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(I_Tt)], [0, imag(I_Tt)], 'b', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    hold off;
    text(real(I_rs), imag(I_rs),'\leftarrow I_{rs}');
    text(real(I_st), imag(I_st),'\leftarrow I_{st}');
    text(real(I_tr), imag(I_tr),'\leftarrow I_{tr}');
    text(real(I_Rr), imag(I_Rr),'\leftarrow I_{Rr}');
    text(real(I_Ss), imag(I_Ss),'\leftarrow I_{Ss}');
    text(real(I_Tt), imag(I_Tt),'\leftarrow I_{Tt}');
    title('Corrientes');
    legend([p3, p4], {'Corrientes de fase', 'Corriente de Linea'});
    grid;
    axis square;
    
    
    %Graficos de Potencias
    subplot(2,2,3);
    hold on;
    plot([0, real(S_rs)], [0, imag(S_rs)], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(S_st)], [0, imag(S_st)], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(S_tr)], [0, imag(S_tr)], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    hold off;
    text(real(S_rs), imag(S_rs),'\leftarrow S_{rs}');
    text(real(S_st), imag(S_st),'\leftarrow S_{st}');
    text(real(S_tr), imag(S_tr),'\leftarrow S_{tr}');
    title('Potencias');
    grid;
    axis square;
    
    
    
    %Triangulo de Potencias
    subplot(2,2,4);
    hold on;
    p5 = plot([0, real(S_t)], [0, 0], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    p6 = plot([real(S_t), real(S_t)], [0, imag(S_t)], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    p7 = plot([0, real(S_t)], [0, imag(S_t)], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    hold off;
    tit1 = strcat('Triangulo de Potencia (phi=', num2str(phi), '°, Fp=', num2str(Fp), ')');
    title(tit1);
    pot1 = strcat('Potencia Activa (P=', num2str(real(S_t)), ' W)');
    pot2 = strcat('Potencia Reactiva (Q=', num2str(imag(S_t)), ' VAR)');
    pot3 = strcat('Potencia Aparente (|S|=', num2str(abs(S_t)), ' VA)');
    legend([p5, p6, p7], {pot1, pot2, pot3});
    grid;
    axis square;
end

