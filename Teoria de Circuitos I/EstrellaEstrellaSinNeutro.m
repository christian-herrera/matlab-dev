% Sistema Estrella - Estrella sin Neutro.
% con GND en el centro de estrella de las bobinas del generador.
%
% Recibe la tensiones de linea (V_RN, V_SN y V_TN)
% luego, las 3 cargas de cada una de las fases.
%
% El algoritmo imprime las tensiones de linea y las corrientes.
% ademas, grafica estos vectores.

function [  ] = EstrellaEstrellaSinNeutro( V_RN, V_SN, V_TN, Zrn, Zsn, Ztn )
    %Tensiones de Linea (Entre fases)
    V_RS = V_RN - V_SN;
    V_ST = V_SN - V_TN;
    V_TR = V_TN - V_RN;
    
    %Obtengo la tension en el nodo n (Centro de estrella de la carga)
    %Esto lo hago planteando nodos en dicho nodo.
    V_nN = ( (V_RN/Zrn) + (V_SN/Zsn) + (V_TN/Ztn) ) / ( (1/Zrn) + (1/Zsn) + (1/Ztn) );
    
    %Tensiones de cada carga.
    V_rn = V_RN - V_nN;
    V_sn = V_SN - V_nN;
    V_tn = V_TN - V_nN;
    
    %Corriente de fase (Corrientes de cada carga) = corrientes de linea
    I_rn = V_rn / Zrn;
    I_sn = V_sn / Zsn;
    I_tn = V_tn / Ztn;
    
    %Potencias complejas de las cargas
    S_rn = V_rn * conj(I_rn);
    S_sn = V_sn * conj(I_sn);
    S_tn = V_tn * conj(I_tn);
    S_t = S_rn + S_sn + S_tn;
    phi = rad2deg(angle(S_t));
    Fp = cosd(phi);
    
    
    %Imprimo las variables
    fprintf('==> Voltaje en en nodo [n] de la carga <==\n');
    fprintf('V_nN = %3.3f | %3.3f°\n\n', abs(V_nN), rad2deg(angle(V_nN)));
    fprintf('==> Tensiones de cada carga <==\n');
    fprintf('V_rn = %3.3f | %3.3f°\t\t', abs(V_rn), rad2deg(angle(V_rn)));
    fprintf('V_sn = %3.3f | %3.3f°\t\t', abs(V_sn), rad2deg(angle(V_sn)));
    fprintf('V_tn = %3.3f | %3.3f°\n\n', abs(V_tn), rad2deg(angle(V_tn)));
    fprintf('==> Corrientes de Fase (De cada carga) <==\n');
    fprintf('I_rn = %3.3f | %3.3f°\t\t', abs(I_rn), rad2deg(angle(I_rn)));
    fprintf('I_sn = %3.3f | %3.3f°\t\t', abs(I_sn), rad2deg(angle(I_sn)));
    fprintf('I_tn = %3.3f | %3.3f°\n\n', abs(I_tn), rad2deg(angle(I_tn)));
    fprintf('==> Potencias Complejas <==\n');
    fprintf('S_rn = %3.3f | %3.3f°\t\t', abs(S_rn), rad2deg(angle(S_rn)));
    fprintf('S_sn = %3.3f | %3.3f°\t\t', abs(S_sn), rad2deg(angle(S_sn)));
    fprintf('S_tn = %3.3f | %3.3f°\t\t', abs(S_tn), rad2deg(angle(S_tn)));
    fprintf('S_t = %3.3f | %3.3f°\t\t', abs(S_t), rad2deg(angle(S_t)));
    
    figure('Name', 'Sistema Estrella - Estrella (Sin Neutro)', 'NumberTitle','off');
    %Grafico Voltajes
    subplot(2,2,1);
    hold on;
    p1 = plot([0, real(V_RN)], [0, imag(V_RN)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_SN)], [0, imag(V_SN)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_TN)], [0, imag(V_TN)], 'g', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    p2 = plot([0, real(V_rn)], [0, imag(V_rn)], 'm', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_sn)], [0, imag(V_sn)], 'm', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    plot([0, real(V_tn)], [0, imag(V_tn)], 'm', 'LineWidth', 2, 'Marker', '*', 'MarkerSize', 5);
    hold off;
    text(real(V_RN), imag(V_RN),'\leftarrow V_{RN}');
    text(real(V_SN), imag(V_SN),'\leftarrow V_{SN}');
    text(real(V_TN), imag(V_TN),'\leftarrow V_{TN}');
    text(real(V_rn), imag(V_rn),'\leftarrow V_{rn}');
    text(real(V_sn), imag(V_sn),'\leftarrow V_{sn}');
    text(real(V_tn), imag(V_tn),'\leftarrow V_{tn}');
    title('Voltajes de Linea y de Cada Carga');
    legend([p1, p2], {'Tensiones de Linea', 'Tensiones de las Cargas'});
    grid;
    axis square;
    
    
    %Graficos de Corrientes
    subplot(2,2,2);
    hold on;
    p3 = plot([0, real(I_rn)], [0, imag(I_rn)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(I_sn)], [0, imag(I_sn)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    plot([0, real(I_tn)], [0, imag(I_tn)], 'r', 'LineWidth', 2, 'Marker', 's', 'MarkerSize', 5);
    hold off;
    text(real(I_rn), imag(I_rn),'\leftarrow I_{rn}');
    text(real(I_sn), imag(I_sn),'\leftarrow I_{sn}');
    text(real(I_tn), imag(I_tn),'\leftarrow I_{tn}');
    title('Corrientes');
    legend([p3], {'Corrientes de Linea'});
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

