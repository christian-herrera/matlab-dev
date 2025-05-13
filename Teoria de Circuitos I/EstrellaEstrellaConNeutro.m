% Sistema Estrella - Estrella con Neutro.
%
% Recibe la tensiones de linea (V_RN, V_SN y V_TN)
% luego, las 3 cargas de cada una de las fases.
%
% El algoritmo imprime las tensiones de linea y las corrientes.
% ademas, grafica estos vectores.

function [  ] = EstrellaEstrellaConNeutro( V_RN, V_SN, V_TN, Zrn, Zsn, Ztn )
    %Tensiones de Linea (Entre fases)
    V_RS = V_RN - V_SN;
    V_ST = V_SN - V_TN;
    V_TR = V_TN - V_RN;
    
    %Corrientes de Linnea = Corriente de Cada Carga
    I_rn = V_RN/Zrn;
    I_sn = V_SN/Zsn;
    I_tn = V_TN/Ztn;
    I_nN = I_rn + I_sn + I_tn;
    
    %Potencias complejas de las cargas
    S_rn = V_RS * conj(I_rn);
    S_sn = V_ST * conj(I_sn);
    S_tn = V_TR * conj(I_tn);
    S_t = S_rn + S_sn + S_tn;
    phi = rad2deg(angle(S_t));
    Fp = cosd(phi);
    
    
    %Imprimo los valores por consola
    fprintf('==> Tensiones de Linea <==\nV_RS: %3.3f | %3.3f\t\t', abs(V_RS), rad2deg(angle(V_RS)));
    fprintf('V_ST: %3.3f | %3.3f\t\t', abs(V_ST), rad2deg(angle(V_ST)));
    fprintf('V_TR: %3.3f | %3.3f\n\n', abs(V_TR), rad2deg(angle(V_TR)));
    fprintf('==> Corrientes de Linea = Corrientes de Fase<==\nI_rs: %3.3f | %3.3f\t\t', abs(I_rn), rad2deg(angle(I_rn)));
    fprintf('I_st: %3.3f | %3.3f\t\t', abs(I_sn), rad2deg(angle(I_sn)));
    fprintf('I_tr: %3.3f | %3.3f\t\t', abs(I_tn), rad2deg(angle(I_tn)));
    fprintf('I_nN: %3.3f | %3.3f\n\n', abs(I_nN), rad2deg(angle(I_nN)));
    fprintf('==> Potencias Complejas <==\nS_rn: %3.3f + j(%3.3f)\t\t', real(S_rn), imag(S_rn));
    fprintf('S_sn: %3.3f + j(%3.3f)\t\t', real(S_sn), imag(S_sn));
    fprintf('S_tn: %3.3f + j(%3.3f)\t\t', real(S_tn), imag(S_tn));
    fprintf('S_total: %3.3f + j(%3.3f)\n', real(S_t), imag(S_t));
    
    
    figure('Name', 'Sistema Estrella - Estrella (Con Neutro)', 'NumberTitle','off');
    %Grafico Voltajes
    subplot(2,2,1);
    hold on;
    p1 = plot([0, real(V_RN)], [0, imag(V_RN)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_SN)], [0, imag(V_SN)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_TN)], [0, imag(V_TN)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    p2 = plot([0, real(V_ST)], [0, imag(V_ST)], 'm', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_TR)], [0, imag(V_TR)], 'm', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_RS)], [0, imag(V_RS)], 'm', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    hold off;
    text(real(V_RN), imag(V_RN),'\leftarrow V_{RN}');
    text(real(V_SN), imag(V_SN),'\leftarrow V_{SN}');
    text(real(V_TN), imag(V_TN),'\leftarrow V_{TN}');
    text(real(V_RS), imag(V_RS),'\leftarrow V_{RS}');
    text(real(V_ST), imag(V_ST),'\leftarrow V_{ST}');
    text(real(V_TR), imag(V_TR),'\leftarrow V_{TR}');
    title('Voltajes de Linea y de Fase');
    legend([p1, p2], {'Tensiones de Linea', 'Tensiones de Fase'});
    grid;
    axis square;
    
    %Graficos de Corrientes
    subplot(2,2,2);
    hold on;
    p3 = plot([0, real(I_rn)], [0, imag(I_rn)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(I_sn)], [0, imag(I_sn)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(I_tn)], [0, imag(I_tn)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    p4 = plot([0, real(I_nN)], [0, imag(I_nN)], 'k', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    hold off;
    text(real(I_rn), imag(I_rn),'\leftarrow I_{rn}');
    text(real(I_sn), imag(I_sn),'\leftarrow I_{sn}');
    text(real(I_tn), imag(I_tn),'\leftarrow I_{tn}');
    text(real(I_nN), imag(I_nN),'\leftarrow I_{nN}');
    title('Corrientes');
    legend([p3, p4], {'Corrientes de Linea', 'Corriente de Neutro'});
    grid;
    axis square;
    
    %Graficos de Potencias
    subplot(2,2,3);
    hold on;
    plot([0, real(S_rn)], [0, imag(S_rn)], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(S_sn)], [0, imag(S_sn)], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(S_tn)], [0, imag(S_tn)], 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    hold off;
    text(real(S_rn), imag(S_rn),'\leftarrow S_{rn}');
    text(real(S_sn), imag(S_sn),'\leftarrow S_{sn}');
    text(real(S_tn), imag(S_tn),'\leftarrow S_{tn}');
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

