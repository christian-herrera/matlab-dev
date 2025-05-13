classdef ControlClasico
    % Contiene los métodos para la realizacion de las prácticas de la asignatura de Control
    % Automático I.

    properties
        
    end
    
    methods
        function obj = ControlClasico()
        end
        
        %=============================================================================%
        function PolosyCerosLA(~, sys)
            % Imprime en consola los polos y ceros del sistema que se le pase como parametro.
            p = pole(sys);
            z = zero(sys);
            nP = length(p);
            nZ = length(z);
            
            % Polos de G(s)
            fprintf('<strong>➤ Polos del Sistema [%i]</strong>\n', nP);
            if nP == 0 
                fprintf('No existen polos finitos en G(s)\n') 
            else
                for i = 1:nP
                    if(isreal(p(i)))
                        fprintf('↳ s%i = [%.3f]\n', i, p(i));
                    else
                        fprintf('↳ s%i = [%.3f + %.3f] \n', i, real(p(i)), imag(p(i)));
                    end
                end
            end
            
            % Ceros de G(s)
            fprintf('<strong>➤ Ceros del Sistema [%i]</strong>\n', nZ);
            if nZ == 0 
                fprintf('↳ No existen ceros finitos en G(s)\n') 
            else
                for i = 1:nZ
                    if(isreal(z(i)))
                        fprintf('↳ s%i = [%.3f]\n', i, z(i));
                    else
                        fprintf('↳ s%i = [%.3f + %.3f] \n', i, real(z(i)), imag(z(i)));
                    end
                end
            end
            %pzplot(sysGH)
        end


        function PolosyCerosLC(obj, G, H)
            % Imprime en consola los polos y ceros del sistema de Lazo Cerrado
            fprintf('<strong>➪ Funcion de Lazo Cerrado (Simplificado)</strong>\n');
            %T = feedback(G, H);
            T = minreal(G/(1 + G*H));
            obj.PolosyCerosLA(T);
        end



        %=============================================================================%
        function ErroresEstaticos(~, sys)    
            % Calcula los errores estáticos del sistema
            Kp = dcgain(sys);
            ess = 1 / (1 + Kp);

            Kv = dcgain(sys * tf([1 0], 1));
            ess_ramp = 1 / Kv;

            Ka = dcgain(sys * tf([1 0 0], 1));
            ess_parabola = 1 / Ka;
            
            fprintf('\n<strong>➤ Errores Estáticos</strong>\n');
            fprintf('↳ Error de estado estacionario al <strong>escalón</strong>:\t\t %.4f\n', ess);
            fprintf('↳ Error de estado estacionario a la <strong>rampa</strong>:\t\t %.4f\n', ess_ramp);
            fprintf('↳ Error de estado estacionario a la <strong>parábola</strong>:\t %.4f\n\n', ess_parabola);
        end
        
        %=============================================================================%

        %=============================================================================%
        function ValEstadoEstacionario(~, sysG, sysH)    
            % Calcula los valores de estado estacionario del sistema
            T = feedback(sysG, sysH);
            val_escalon = dcgain(T);
            val_rampa = dcgain(T * tf(1, [1 0]));
            val_parabola = dcgain(T * tf(1, [1 0 0]));
            
            fprintf('\n<strong>➤ Valores Estáticos y(∞)</strong>\n');
            fprintf('↳ Valor de estado estacionario al <strong>escalón</strong>:\t\t %.4f\n', val_escalon);
            fprintf('↳ Valor de estado estacionario a la <strong>rampa</strong>:\t\t %.4f\n', val_rampa);
            fprintf('↳ Valor de estado estacionario a la <strong>parábola</strong>:\t %.4f\n\n', val_parabola);
        end
        
        %=============================================================================%
        

        %=============================================================================%
        function LGR(~, sysG, sysH)    
            % Realiza la grafica del Diagrama de Lugar Raices
            figure;
            h = rlocusplot(sysG*sysH);
            opt = getoptions(h);
            opt.Grid = 'On';
            opt.Title.String = "Diagrama de Lugar Raices";
            setoptions(h, opt);
            % Set the line width for the root locus plot lines
            lines = findall(gcf, 'Type', 'line');
            set(lines, 'LineWidth', 1.5);
            
            % Ensure the grid lines retain their default width
            gridLines = findall(gcf, 'Type', 'line', 'Tag', 'CSTgridLines');
            set(gridLines, 'LineWidth', 0.5); % or any other default value
        end
        
        %=============================================================================%
        function k = GananciaCritica(~, sysG, sysH)
            % Devuelve el valor de ganancia que vuelve inestable al sistema.
            warning('off', 'all'); % Turn off all warnings
            [k, ~] = margin(sysG*sysH);
            warning('on', 'all'); % Turn warnings back on
            fprintf('\n<strong>➤ Ganancia Critica</strong>\n');
            if isinf(k)
                fprintf('↳ No existe ganancia critica!\n');
            else
                fprintf('↳ k = [%.3f]\n', k);
            end
        end
        
        %=============================================================================%
        function RouthTable(~, sysG, sysH)
            % Obtiene los coeficientes del polinomio característico
            [~, coeffs] = tfdata(sysG * sysH, 'v');
                        
            % Número de filas de la tabla de Routh
            n = length(coeffs);
            
            % Inicializa la tabla de Routh con ceros
            routhTable = zeros(n, ceil(n/2));
            
            % Llena la primera fila con los coeficientes de los términos de potencia par
            routhTable(1, :) = coeffs(1:2:end);
            
            % Llena la segunda fila con los coeficientes de los términos de potencia impar
            if length(coeffs) > 1
                routhTable(2, 1:length(coeffs(2:2:end))) = coeffs(2:2:end);
            end
            
            % Construye el resto de la tabla de Routh
            for i = 3:n
                for j = 1:ceil((n-i+1)/2)
                    routhTable(i, j) = (routhTable(i-1, 1) * routhTable(i-2, j+1) - routhTable(i-2, 1) * routhTable(i-1, j+1)) / routhTable(i-1, 1);
                end
            end
            
            % Imprime la tabla de Routh
            fprintf('\n<strong>➤ Tabla de Routh:\n\n</strong>');
            for i = 1:n
                fprintf('\ts^%i: ', n-i);
                for j=1:ceil((n-i+1)/2)
                    fprintf('\t%.2f \t', routhTable(i, j));
                end
                fprintf('\n');
            end
        end



        %=============================================================================%        
        function nyquist(obj, sys, LineWidth, n)
            % Permite realizar el diagrama de Nyquist en escala logaritmica.
            % Requiere de los parametros:
            % - sys:       Funcion de transferencia de lazo abierto
            % - LineWidth: Ancho del trazo
            % - N:         Numero del nivel de lineas
            if nargin < 4
                LineWidth = 1.7;
                n = 6;
            elseif narging < 2
                fprintf('\n<strong>➤ ERROR, Faltan argumentos...</strong>\n\n');
                return
            end

            
            Lw=LineWidth;   % Linewidth
            Nd=6;           % Number of level lines
            NgPlot=1;       % Negative Plot=1 complete Nyquist plot, 0 only positive frequency
            
            clear XD
            XD.c = 'r'; 
            XD.Lw = Lw; 
            XD.NgPlot = NgPlot; 
            XD.gs = sys;
            %--------------------------------------------
            figure; clf
            plot(2*exp(1i*(0:0.01:1)*2*pi),'-')
            hold on
            grid on
            plot(exp(1i*(0:0.01:1)*2*pi),'-')
            plot(exp(1i*pi),'*r')
            text(-1.05,-0.05,'-1')
            xx=1*exp(1i*pi/4);
            text(real(xx),imag(xx),[num2str(0) 'dB'])
            for ii=1:Nd
                plot(1/(n^ii)*exp(1i*(0:0.01:1)*2*pi),':')
                plot((2-1/(n^ii))*exp(1i*(0:0.01:1)*2*pi),':')
                if ii<3
                    xx=1/(n^ii)*exp(1i*pi/4);
                    text(real(xx),imag(xx),[num2str(-ii*20) 'dB'])
                    xx=(2-n^(-ii))*exp(1i*pi/4);
                    text(real(xx),imag(xx),[num2str(ii*20) 'dB'])
                end
            end
            for ii=1:12 % plot of sectors of pi/6
                ps=2*exp(1i*ii*pi/6);
                plot([0 real(ps)],[0 imag(ps)],':')
            end
            plot([-1 1]*3,[-1 1]*0,':')
            plot([-1 1]*0,[-1 1]*3,':')
            axis equal
            axis([-1 1 -1 1]*2.2)

            [RE,IM,~] = nyquist(XD.gs,logspace(-Nd,Nd,1000));
            NY=(RE(:,:)+1i*IM(:,:));

            %--------------------------------------------
            NY_L2 = obj.CLN(NY,n);
            plot(NY_L2,XD.c,'LineWidth',Lw)
            % Arrows
            pp=[150 480 600 800];
            for jj=pp % arrows for w>0
                obj.arrowc(real(NY_L2(jj)),imag(NY_L2(jj)),real(NY_L2(jj+1)),imag(NY_L2(jj+1)),0.1,0.1,'r')
            end
            if XD.NgPlot==1    % plot for w<0 and complete
                obj.Complete_Ny(NY_L2,XD);
                plot(conj(NY_L2),'Color',XD.c,'Linewidth',XD.Lw,'Linestyle','--')
                pp=[150 480 600];
                for jj=pp % arrows for w<0
                    obj.arrowc(real(conj(NY_L2(jj))),imag(conj(NY_L2(jj))),real(conj(NY_L2(jj-1))),imag(conj(NY_L2(jj-1))),0.1,0.1,'r')
                end
            end
            grid on
            title('Closed Logarithmic Nyquist Plot')
            xlabel('Real')
            ylabel('Imag')
            hold off
        end


        %=============================================================================%        
        function bode(~, F, limits)
            % Realiza el grafico de Bode en escala logaritmica.
            figure;
            if nargin == 3
                margin(F, limits);
            else
                margin(F);
            end
            grid on;

            % [mag, phase, w] = bode(F, opt);
            % figure;
            % subplot(2,1,1)
            % semilogx(w, 20*log10(squeeze(mag)), '-r', 'LineWidth',2)
            % grid
            % subplot(2,1,2)
            % semilogx(w, squeeze(phase), '-r', 'LineWidth',2)
            % grid
        end


    end

    methods (Access = private)
        %=============================================================================% 
        % Funciones Privadas para el Metodo: Nyquist
        %- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -%
        function h = Complete_Ny(obj, NY,X)
            Np_origin=length(find(pole(X.gs)==0)); % Number of poles at the origin
            vv=(angle(conj(NY(1))):-0.02:angle(conj(NY(1)))-Np_origin*pi);
            delta_spiral=0.003*(Np_origin>2);
            if X.NgPlot
                xx=max(2,abs(NY(1)))*(1-delta_spiral*vv).*exp(1i*vv);
                plot(xx,'Color',X.c,'Linewidth',X.Lw,'Linestyle','--')
                plot([real(xx(end)) real(NY(1))],[imag(xx(end)) imag(NY(1))],'Color',X.c,'Linewidth',X.Lw,'Linestyle','-')
                Nr_arrow=2*Np_origin; % Number of arrows
                if Nr_arrow>0
                    for jj=1:Nr_arrow
                        pp=jj*round(size(xx,2)/(Nr_arrow+1));
                        obj.arrowc(real(xx(pp)),imag(xx(pp)),real(xx(pp+1)),imag(xx(pp+1)),0.1,0.1,'r')
                    end
                end
            end
            h=xx;
        end
        %- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -%
        function arrowc(~, x0,y0,x,y,rx,ry,c)
            % Plots an arrow at (x,y) along vector dx=x-x0, dy=y-y0. The length of the arrow
            % is rx and ry in the directions x and y. The arrow color is c.
            Lw=1.2;         % Linewidth
            dx=(x-x0)/rx;
            dy=(y-y0)/ry;
            dxy=sqrt(dx^2+dy^2);
            fx=-dx/dxy;
            fy=-dy/dxy;
            rotpiu=[rx,0;0,ry]*[cos(pi/6), -sin(pi/6); sin(pi/6), cos(pi/6) ]*[fx,fy]';
            rotmeno=[rx,0;0,ry]*[cos(pi/6), sin(pi/6); -sin(pi/6), cos(pi/6) ]*[fx,fy]';
            plot([x0,x],[y0,y],'-')
            plot([x,x+rotpiu(1)],[y,y+rotpiu(2)],c,'LineWidth',Lw)
            plot([x,x+rotmeno(1)],[y,y+rotmeno(2)],c,'LineWidth',Lw)
        end
        %- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -%
        function Ln=CLN(~, NY,n)
            RE=real(NY);
            IM=imag(NY);
            MD=sqrt(RE.^2+IM.^2);   % Modulo
            PH=atan2(IM,RE);        % Fase
            MD2=MD.^(log10(n));
            ind=find(MD2>1);
            MD2(ind)=2-1./MD2(ind);
            Ln=MD2.*exp(1i*PH);
        end
        %=============================================================================% 
    end
end
