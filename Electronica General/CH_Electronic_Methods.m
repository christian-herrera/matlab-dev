classdef CH_Electronic_Methods
    % Esta clase contiene los métodos mas elementales de la Electronica en general.
    %
    % Se utiliza de la siguiente manera:
    %
    %   obj = CH_Electronic_Methods();
    
    properties
        
    end
    
    methods
        function obj = CH_Electronic_Methods()
            % Constructor de la clase
        end
        
        function [Zeq] = Zeq(~, Z_list)
            % Calcula el paralelo de las impedancias pasadas como vector.
            Zeq = 0;
            for i=1:length(Z_list)
                Zeq = Zeq + 1/Z_list(i);
            end
            Zeq = 1/Zeq;
        end


        function printComplex(~, val, label)
            % Imprime un numero complejo en forma polar.
            mod = abs(val);
            ang = angle(val);
            fprintf('%s = %.4e < %.4e °\n', label, mod, ang);
        end



        function complex2impedance(~, val, f)
            % Convierte un numero complejo a una impedancia, usando la frecuencia que se recibe como argumento.
            
            if(imag(val) == 0)
                fprintf('Resistencia:\nR = %.3e Ohms\n', real(val));
            elseif(imag(val) > 0)
                fprintf('Resistencia + Inductor (Serie):\nR = %.3e Ohms\nL = %.3e H\n', real(val), imag(val)/2/pi/f);
            else
                fprintf('Resistencia + Capacitor (Serie):\nR = %.3e Ohms\nC = %.3e F\n', real(val), 1/(2*pi*f*abs(imag(val))));
            end
        end
    end
end

