function res_loads=loads(x)

global data;
x = x.*data.x0;

import wing_surface.*
import MAC.*
% x = [4.5  1.04  20.04  4  -7  27  27 0.3156    0.2076    0.2577  0.1669    0.2176   0.1868   -0.1133 -0.0853   -0.2094   -0.0577 -0.1707     -0.1192 0.2712    0.2148 0.1857    0.1861  0.1684   0.1727   -0.0957   -0.0388 -0.2101   -0.0114   -0.1612  -0.0911 0.5824 0.0282...
%         2.3527 2.3583  2.3596  2.3455  2.3048  2.2127 2.0801  1.9136  1.7202  1.5041  1.2683  1.0142  0.7409  0.4378 -0.1335  -0.0932  -0.0694  -0.0536  -0.0424 -0.0287  -0.0226  -0.0197  -0.0177  -0.0161  -0.0145 -0.0128  -0.0107  -0.0066  1006.9  2865];

MTOW =  x(62) + x(63) + data.weight_AW; %data.MTOWinitial  
MTOW_lbs = MTOW * 2.2046;

nmax = 2.1 + (24000/(MTOW_lbs+10000));


%% Aerodynamic solver setting
x_LE_kink = data.y_kink * tand(x(6)); 
y_LE_kink = data.y_kink;
z_LE_kink = data.y_kink * tand(data.dihedral);

chord_kink = (x(1) + data.y_kink * tand(0.1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * x(3) - data.y_kink) * tand(x(7)); 
y_LE_tip = x(3)/2;
z_LE_tip = 0.5 * x(3) * tand(data.dihedral);
% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = [0               0              0       x(1)    0;
               x_LE_kink    y_LE_kink    z_LE_kink   chord_kink    x(4);
               x_LE_tip     y_LE_tip     z_LE_tip       x(2)     x(5)];

% Wing incidence angle (degree)
AC.Wing.inc  = 0; 
AC.Aero.MaxIterIndex = 150;
                        
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                           <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [x(8)  x(9)  x(10)  x(11)  x(12) x(13) x(14) x(15) x(16) x(17) x(18) x(19);
                        x(20)   x(21)   x(22)   x(23)   x(24)   x(25)   x(26)   x(27)   x(28)   x(29)   x(30)   x(31)];
                  
                  
                  
AC.Wing.eta = [0;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 0;              % 0 for inviscid and 1 for viscous analysis
% 
% AC.Aero.V     = 150;            % flight speed (m/s)
% AC.Aero.rho   = 1.225;         % air density  (kg/m3)
% AC.Aero.alt   = 0;             % flight altitude (m)
% AC.Aero.Re    = (MAC(x)*AC.Aero.V*1.225)/(1.8*10^-5);        % reynolds number (bqased on mean aerodynamic chord)
% AC.Aero.M     = AC.Aero.V/343;           % flight Mach number 
% AC.Aero.CL    = (MTOW * 9.81 * nmax)/(0.5*AC.Aero.rho*(AC.Aero.V^2)*2*wing_surface(x));  
%  
 % Flight Condition
 AC.Aero.V     = 233;            % Vmo (max operating flight speed (m/s))
 AC.Aero.rho   = 0.348;       % cruise air density  (kg/m3)
 AC.Aero.alt   = 11647;           % cruise flight altitude (m)
 AC.Aero.Re    = (MAC(x)* AC.Aero.rho * AC.Aero.V)/(1.43e-5) ;        % reynolds number (bqased on mean aerodynamic chord)
 AC.Aero.M     = 0.78;           % flight Mach number 
 AC.Aero.CL    = (nmax * MTOW * 9.81)/(0.5 * AC.Aero.V^2 * AC.Aero.rho * wing_surface(x)*2);   % target lift coefficient - comment this line to run the code for given alpha%
 AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 

%% 
res_loads = Q3D_solver(AC);
out1 = round(res_loads.Wing.ccl,4);
out2 = round(res_loads.Wing.cm_c4 .* res_loads.Wing.chord,4);
res_loads = [out1 out2];
