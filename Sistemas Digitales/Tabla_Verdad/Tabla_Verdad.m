function [] = Tabla_Verdad(F)
    %Imprime la Tabla de Verdad en Consola. No tiene un limite en cuanto a la cantidad de variables
    %pero se recomienda que sea menor a 10 para no sobrecargar la consola.
    %
    % - Operadores Disponibles:
    %       &        : AND
    %       |        : OR
    %       ~        : NOT
    %       xor(A,B) : XOR
    %
    % - Parametros:
    %       F: Sera una funcion anonima con todos operadores logicos.
    %
    % - Ejemplo:
    %       F = @(A, B)( A&B );
    %       Tabla_Verdad(F);
    %   
    %By <a href="matlab:web('https://christianherrera.com.ar')">Christian Herrera</a>.
    
    n = nargin(F);
    
    if n < 2
        fprintf('<strong> ➤ Se requieren al menos 2 variables! </strong>\n');
        return;
    end

    if n > 10
        fprintf('<strong> ➤ Advertencia: Mas de 10 variables puede ser muy pesado para mostrar en consola!</strong>\n');
    end

    % =====> Generar todas las combinaciones posibles de 0 y 1 para n variables
    % Para n=3:
    %  > 0:2^n-1 => [0 1 2 3 4 5 6 7]
    %  > dec2bin(0:2^n-1) => char array{ '000', '001', '010', '011', '100', '101', '110', '111'}
    %  > Resto '0' que vale 48 en ASCII, recordar que '011' = ['0', '1', '1'], con lo cual:
    %    con lo cual '011' - '0' = ['0', '1', '1'] - '0' = [48, 49, 49] - 48 = [0, 1, 1].
    combinaciones = dec2bin(0:2^n-1) - '0';  % convierte binario a matriz de 0s y 1s
    
    % =====> Encabezado dinámico
    fprintf('<strong> ➤ Tabla de Verdad (%d variables)</strong>\n', n);
    for i = 1:n
        fprintf('\t%c', 'A' + (i-1));
    end
    fprintf('\t|\tF\n');
    fprintf('   %s\n', repmat('-', 1, n*8));

    % =====> Evaluar la función F para cada fila
    for i = 1:size(combinaciones, 1)
        entrada = num2cell(combinaciones(i, :));  % convierte fila en celda
        salida = F(entrada{:});  % llama la función con n argumentos
        for j = 1:n
            fprintf('\t%d', combinaciones(i, j));
        end
        fprintf('\t|\t%d\n', salida);
    end
end
