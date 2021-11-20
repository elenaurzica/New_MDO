function res_aero = aerodynamics(x)
%% Aerodynamic solver setting
global data

x = x .* data.x0;  %DENORMALIZING DESIGN VECTOR BC x0 is normalised
import wing_surface.*
import MAC.*
% OLD ONE: x = [4.24  0.98  20.04  4  -7  27  27 0.3156    0.2076    0.2577  0.1669    0.2176   0.1868   -0.1133 -0.0853   -0.2094   -0.0577 -0.1707     -0.1192 0.2712    0.2148 0.1857    0.1861  0.1684   0.1727   -0.0957   -0.0388 -0.2101   -0.0114   -0.1612  -0.0911 0.5824 0.0282...
%        2.3527 2.3583  2.3596  2.3455  2.3048  2.2127 2.0801  1.9136  1.7202  1.5041  1.2683  1.0142  0.7409  0.4378 -0.1335  -0.0932  -0.0694  -0.0536  -0.0424 -0.0287  -0.0226  -0.0197  -0.0177  -0.0161  -0.0145 -0.0128  -0.0107  -0.0066  1245.4  2967];


% x = [4.5 1.04 20.04  4  -7  27  27 0.3156    0.2076    0.2577  0.1669    0.2176   0.1868   -0.1133 -0.0853   -0.2094   -0.0577 -0.1707     -0.1192 0.2712    0.2148 0.1857    0.1861  0.1684   0.1727   -0.0957   -0.0388 -0.2101   -0.0114   -0.1612  -0.0911...
%     0.482 0.0185 1.7080  1.7316 1.7636  1.7908 1.7985 1.7534 1.6533   1.5145    1.3446  1.1485  0.9300 0.6935  0.4455  0.2005 ...
%     -0.1795 -0.1396 -0.1089  -0.0845  -0.0639  -0.0459 -0.0349 -0.0286 -0.0240 -0.0210 -0.0186 -0.0175 -0.0176 -0.0191 1015.5 2865];

MTOW = x(62) + x(63) + data.weight_AW;  %des_vec =normalized. times absolute nonormalized reference data vector

x_LE_kink = data.y_kink * tand(x(6)); 
y_LE_kink = data.y_kink;
z_LE_kink = data.y_kink * tand(data.dihedral);

chord_kink = (x(1) + data.y_kink * tand(1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * x(3) - data.y_kink) * tand(x(7)); 
y_LE_tip = x(3)/2;
z_LE_tip = 0.5 * x(3) * tand(data.dihedral);

% Wing planform geometry 
%                x           y               z           chord(m)            twist angle (deg) 
AC.Wing.Geom =  [0           0              0           x(1)                0;
               x_LE_kink    y_LE_kink    z_LE_kink      chord_kink          x(4);
               x_LE_tip     y_LE_tip     z_LE_tip       x(2)                x(5)];

% Wing incidence angle (degree)
AC.Wing.inc  = 0;          
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                           <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   =  [x(8)  x(9)  x(10)  x(11)  x(12) x(13) x(14) x(15) x(16) x(17) x(18) x(19);
                        x(20)   x(21)   x(22)   x(23)   x(24)   x(25)   x(26)   x(27)   x(28)   x(29)   x(30)   x(31)];
   
                
                  
AC.Wing.eta = [0;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 1;              % 0 for inviscid and 1 for viscous analysis
AC.Aero.MaxIterIndex = 150;  

% Flight Condition  --- OLD
% AC.Aero.V     = 200;        % cruise flight speed (m/s))
% AC.Aero.rho   =  0.4135;          % cruise air density  (kg/m3)
% AC.Aero.alt   = 10000;             % cruise flight altitude (m)
% AC.Aero.Re    = ((wing_surface(x)/x(3)) * AC.Aero.rho * AC.Aero.V)/(1e-5) ;  % reynolds number (based on mean aerodynamic chord)
% AC.Aero.M     = 0.66;           % flight Mach number 
% AC.Aero.CL    = (MTOW * 9.81)/(0.5*(AC.Aero.V^2)*2*wing_surface(x)*0.4135); %x()clwingtarget;   % target lift coefficient - comment this line to run the code for given alpha%
% AC.Aero.Alpha = 2;               % angle of attack -  comment this line to run the code for given cl 

% Flight Condition
AC.Aero.V     = 210;       % cruise flight speed (m/s))
AC.Aero.rho   =  0.348;          % cruise air density  (kg/m3)
AC.Aero.alt   = 11647;             % cruise flight altitude (m)
AC.Aero.Re    = (MAC(x) * AC.Aero.rho * AC.Aero.V)/(1.43e-5) ;  % reynolds number (based on mean aerodynamic chord)
AC.Aero.M     = 0.66;           % flight Mach number 
AC.Aero.CL    = (MTOW * 9.81)/(0.5*AC.Aero.rho*(AC.Aero.V^2)*2*wing_surface(x)); %x()clwingtarget;   % target lift coefficient - comment this line to run the code for given alpha%
AC.Aero.Alpha = 2;               % angle of attack -  comment this line to run the code for given cl 





%% 

aero_out = Q3D_solver(AC);
res_aero = [aero_out.CLwing  aero_out.CDwing];
% catch
% % cd 'C:\Users\elena\Documents\Msc PP\Q1_new\MDO\Assignment'
% end
end



     